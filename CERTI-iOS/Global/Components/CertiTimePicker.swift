//
//  CertiTimePicker.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 11/21/25.
//

import SwiftUI
import UIKit

// MARK: - SwiftUI Component

struct CertiTimePicker: View {
    @Binding var isAM: Bool
    @Binding var hour: Int
    @Binding var minute: Int
    
    var body: some View {
        ZStack {
            CustomTimePicker(isAM: $isAM, hour: $hour, minute: $minute)
                .frame(height: 180)
            
            Text(":")
                .applyCertiFont(.caption_semibold_14)
                .foregroundColor(.grayscale600)
                .offset(x: 49, y: 0)
        }
    }
}

// MARK: - UIKit View

final class CertiPickerView: UIPickerView {
    
    private var topLines: [UIView] = []
    private var bottomLines: [UIView] = []
    private var didHideIndicator = false
    private var lastBounds: CGRect = .zero
    
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
            topLine.backgroundColor = .purpleblue
            addSubview(topLine)
            topLines.append(topLine)
            
            let bottomLine = UIView()
            bottomLine.backgroundColor = .purpleblue
            addSubview(bottomLine)
            bottomLines.append(bottomLine)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !didHideIndicator {
            hideIndicator()
            didHideIndicator = true
        }
        
        if bounds != lastBounds {
            layoutLines()
            lastBounds = bounds
        }
    }
}

// MARK: - Layout Methods

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
        let totalContentWidth = layouts.map { $0.textWidth }.reduce(0, +) + lineSpacing.reduce(0, +)
        
        var xOffset: CGFloat = (bounds.width - totalContentWidth) / 2
        
        let rowHeight = rowSize(forComponent: 0).height
        let lineHeight: CGFloat = 2
        let topLineY = bounds.midY - rowHeight / 2
        let bottomLineY = bounds.midY + rowHeight / 2
        
        for i in 0..<layouts.count {
            let layout = layouts[i]
            
            var centerX = xOffset + layout.textWidth / 2
            centerX += layout.lineLocationValue
            
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
            
            if i < lineSpacing.count {
                xOffset += layout.textWidth + lineSpacing[i]
            } else {
                xOffset += layout.textWidth
            }
        }
    }
}

// MARK: - UIViewRepresentable

struct CustomTimePicker: UIViewRepresentable {
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
        
        let middleHourIndex = Coordinator.hoursInfinite.count / 2
        let middleMinuteIndex = Coordinator.minutesInfinite.count / 2
        
        picker.selectRow(isAM ? 0 : 1, inComponent: 0, animated: false)
        picker.selectRow(middleHourIndex + (hour - 1), inComponent: 1, animated: false)
        picker.selectRow(middleMinuteIndex + (minute / 5), inComponent: 2, animated: false)
        
        context.coordinator.currentHourRow = middleHourIndex + (hour - 1)
        context.coordinator.currentMinuteRow = middleMinuteIndex + (minute / 5)
        
        return picker
    }
    
    func updateUIView(_ uiView: UIPickerView, context: Context) {
        let meridiemRow = isAM ? 0 : 1
        
        if uiView.selectedRow(inComponent: 0) != meridiemRow {
            uiView.selectRow(meridiemRow, inComponent: 0, animated: false)
        }
        
        let currentHourRow = uiView.selectedRow(inComponent: 1)
        let currentDisplayedHour = Coordinator.hoursInfinite[currentHourRow]
        
        if currentDisplayedHour != hour {
            let middleIndex = Coordinator.hoursInfinite.count / 2
            uiView.selectRow(middleIndex + (hour - 1), inComponent: 1, animated: false)
        }
        
        let currentMinuteRow = uiView.selectedRow(inComponent: 2)
        let currentDisplayedMinute = Coordinator.minutesInfinite[currentMinuteRow]
        
        if currentDisplayedMinute != minute {
            let middleIndex = Coordinator.minutesInfinite.count / 2
            uiView.selectRow(middleIndex + (minute / 5), inComponent: 2, animated: false)
        }
    }
}

// MARK: - Coordinator

extension CustomTimePicker {
    class Coordinator: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
        private var parent: CustomTimePicker
        
        fileprivate var currentHourRow: Int?
        fileprivate var currentMinuteRow: Int?
        
        static let ampm: [String] = ["오전", "오후"]
        static let hours: [Int] = Array(1...12)
        static let minutes: [Int] = Array(stride(from: 0, to: 60, by: 5))
        static let hoursInfinite: [Int] = Array(repeating: hours, count: 30).flatMap { $0 }
        static let minutesInfinite: [Int] = Array(repeating: minutes, count: 30).flatMap { $0 }
        
        init(_ parent: CustomTimePicker) {
            self.parent = parent
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 3
        }
        
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
            
            let label: UILabel
            if let reused = view as? UILabel {
                label = reused
            } else {
                label = UILabel()
                label.textAlignment = .center
                label.font = UIFont(name: "Pretendard-SemiBold", size: 14)
                label.textColor = UIColor(named: "grayscale600")
            }
            
            switch component {
            case 0: label.text = Self.ampm[row]
            case 1: label.text = "\(Self.hoursInfinite[row])"
            case 2: label.text = String(format: "%02d", Self.minutesInfinite[row])
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
                currentHourRow = row
                parent.hour = Self.hoursInfinite[row]
            case 2:
                currentMinuteRow = row
                parent.minute = Self.minutesInfinite[row]
            default: break
            }
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State var isAM = true
        @State var hour = 1
        @State var minute = 0
        
        var body: some View {
            CertiTimePicker(isAM: $isAM, hour: $hour, minute: $minute)
        }
    }
    return PreviewWrapper()
}

