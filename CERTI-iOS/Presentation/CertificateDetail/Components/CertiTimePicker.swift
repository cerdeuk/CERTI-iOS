//
//  CertiTimePicker.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 11/21/25.
//

import SwiftUI
import UIKit

final class CertiPickerView: UIPickerView {
    
    private var topLines: [UIView] = []
    private var bottomLines: [UIView] = []
    
    private struct ComponentLayout {
        let textWidth: CGFloat
        let lineLocationValue: CGFloat
        let lineWidth: CGFloat
    }
    
    private let layouts: [ComponentLayout] = [
        .init(textWidth: 45,  lineLocationValue: 5,  lineWidth: 45),
        .init(textWidth: 129, lineLocationValue: 0,  lineWidth: 35),
        .init(textWidth: 38,  lineLocationValue: -7, lineWidth: 38)
    ]
    
    private let lineSpacing: [CGFloat] = [12, 10]

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLines()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLines()
    }
    
    private func setupLines() {
        for _ in 0..<3 {
            let topLine = UIView()
            topLine.backgroundColor = UIColor(Color.purpleblue)
            addSubview(topLine)
            topLines.append(topLine)
            
            let bottomLine = UIView()
            bottomLine.backgroundColor = UIColor(Color.purpleblue)
            addSubview(bottomLine)
            bottomLines.append(bottomLine)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        hideIndicator()
        layoutLines()
    }
}


// MARK: - Private Layout Methods

private extension CertiPickerView {
    func hideIndicator() {
        for sub in subviews {
            let isIndicator =
                sub.subviews.isEmpty &&
                sub.bounds.height > 5 &&
                sub.bounds.height < 60

            if isIndicator {
                sub.isHidden = true
                sub.alpha = 0
            }
        }
    }
    
    func layoutLines() {
        // 전체 폭 계산
        let totalContentWidth =
            layouts.map { $0.textWidth }.reduce(0, +) + lineSpacing.reduce(0, +)
        
        // 왼쪽 여백: picker 중앙에 맞추기 위한 offset
        var xOffset: CGFloat = (bounds.width - totalContentWidth) / 2
        
        let rowHeight = rowSize(forComponent: 0).height
        let lineHeight: CGFloat = 2
        let topLineY = bounds.midY - rowHeight / 2
        let bottomLineY = bounds.midY + rowHeight / 2
        
        for i in 0..<layouts.count {
            let layout = layouts[i]
            
            // 각 컴포넌트의 중앙 X
            var centerX = xOffset + layout.textWidth / 2
            centerX += layout.lineLocationValue
            
            // 라인 X 계산
            let lineX = centerX - layout.lineWidth / 2
            
            topLines[i].frame = CGRect(
                x: lineX,
                y: topLineY,
                width: layout.lineWidth,
                height: lineHeight
            )
            
            bottomLines[i].frame = CGRect(
                x: lineX,
                y: bottomLineY,
                width: layout.lineWidth,
                height: lineHeight
            )
            
            // 다음 컴포넌트 시작점 이동
            if i < lineSpacing.count {
                xOffset += layout.textWidth + lineSpacing[i]
            } else {
                xOffset += layout.textWidth
            }
        }
    }
}

struct CertiTimePicker: UIViewRepresentable {
    @Binding var isAM: Bool
    @Binding var hour: Int
    @Binding var minute: Int

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UIPickerView {
        let picker = CertiPickerView()
        picker.delegate = context.coordinator
        picker.dataSource = context.coordinator
        return picker
    }

    func updateUIView(_ uiView: UIPickerView, context: Context) {
        uiView.selectRow(isAM ? 0 : 1, inComponent: 0, animated: false)
        uiView.selectRow(hour - 1, inComponent: 1, animated: false)
        uiView.selectRow(minute / 5, inComponent: 2, animated: false)
    }

    class Coordinator: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
        var parent: CertiTimePicker

        static let ampm: [String] = ["오전", "오후"]
        static let hours: [Int] = Array(1...12)
        static let minutes: [Int] = Array(stride(from: 0, to: 60, by: 5))
        static let hoursInfinite: [Int] = Array(repeating: hours, count: 100).flatMap { $0 }
        static let minutesInfinite: [Int] = Array(repeating: minutes, count: 100).flatMap { $0 }


        init(_ parent: CertiTimePicker) {
            self.parent = parent
        }

        func numberOfComponents(in pickerView: UIPickerView) -> Int { 3 }

        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            switch component {
            case 0: return Self.ampm.count
            case 1: return Self.hoursInfinite.count
            case 2: return Self.minutesInfinite.count
            default: return 0
            }
        }

        func pickerView(_ pickerView: UIPickerView,
                        viewForRow row: Int,
                        forComponent component: Int,
                        reusing view: UIView?) -> UIView {

            let label = UILabel()
            label.textAlignment = .center
            label.font = UIFont(name: "Pretendard-SemiBold", size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .semibold)
            label.textColor = .black

            switch component {
            case 0: label.text = Self.ampm[row]
            case 1: label.text = "\(Self.hoursInfinite[row % 12])"
            case 2: label.text = String(format: "%02d", Self.minutesInfinite[row % 12])
            default: break
            }
            
            return label
        }

        func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
            switch component {
            case 0: return 45
            case 1: return 129
            case 2: return 38
            default: return 50
            }
        }
        
        func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
            return 40
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            switch component {
            case 0:
                parent.isAM = (row == 0)
            case 1:
                parent.hour = Self.hoursInfinite[row % 12]
            case 2:
                parent.minute = Self.minutesInfinite[row % 12]
            default: break
            }
        }
    }
}

#Preview {
    @State var isAM = true
    @State var hour = 1
    @State var minute = 0
    ZStack {
        CertiTimePicker(isAM: $isAM, hour: $hour, minute: $minute)
            .frame(height: 180)
     
        Text(":")
            .applyCertiFont(.caption_semibold_14)
            .offset(x: 49, y: 0)
    }
}

