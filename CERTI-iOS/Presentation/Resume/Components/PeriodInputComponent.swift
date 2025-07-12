//
//  PeriodInputComponent.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/12/25.
//

import SwiftUI

struct PeriodInputComponent: View {
    @State private var startDate: Date? = nil
    @State private var endDate: Date? = nil
    @State private var isStartDateExpanded = false
    @State private var isEndDateExpanded = false
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 0) {
                customDatePicker(
                    selectedDate: $startDate,
                    isExpanded: $isStartDateExpanded,
                    placeholder: "시작일"
                )
                
                Text("부터")
                    .applyCertiFont(.caption_semibold_14)
                    .foregroundStyle(.grayscale600)
                    .frame(height: 20)
                    .padding(.leading, 8)
                    .padding(.trailing, 10)

                customDatePicker(
                    selectedDate: $endDate,
                    isExpanded: $isEndDateExpanded,
                    placeholder: "종료일"
                )
                
                Text("까지")
                    .applyCertiFont(.caption_semibold_14)
                    .foregroundStyle(.grayscale600)
                    .frame(height: 20)
                    .padding(.leading, 8)
                
                Spacer()
            }
            if isStartDateExpanded {
                withAnimation(.easeInOut(duration: 0.2)) {
                    DatePicker("", selection: Binding<Date>(
                        get: { startDate ?? Date() },
                        set: {
                            startDate = $0
                            if let end = endDate, $0 > end {
                                endDate = $0
                            }
                        }
                    ), displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .environment(\.locale, Locale(identifier: "ko_KR"))
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.05), radius: 20, x: 4, y: 4)
                    .frame(maxWidth: .infinity)
                    .onChange(of: startDate) { _ in
                        withAnimation(.easeInOut(duration: 0.2)) {
                            isStartDateExpanded = false
                        }
                    }
                }
            } else if isEndDateExpanded {
                withAnimation(.easeInOut(duration: 0.2)) {
                    DatePicker("", selection: Binding<Date>(
                        get: { endDate ?? Date() },
                        set: {
                            endDate = $0
                            if let start = startDate, $0 < start {
                                startDate = $0
                            }
                        }
                    ), displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .environment(\.locale, Locale(identifier: "ko_KR"))
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 8)
                    .frame(maxWidth: .infinity)
                    .onChange(of: endDate) { _ in
                        withAnimation(.easeInOut(duration: 0.2)) {
                            isEndDateExpanded = false
                        }
                    }
                }
            }
        }
        .padding()
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }
}

extension PeriodInputComponent {
    private func customDatePicker(
        selectedDate: Binding<Date?>,
        isExpanded: Binding<Bool>,
        placeholder: String
    ) -> some View {
        VStack {
            Button {
                if placeholder == "시작일" {
                    isEndDateExpanded = false
                } else {
                    isStartDateExpanded = false
                }
                
                withAnimation(.easeInOut(duration: 0.2)) {
                    isExpanded.wrappedValue.toggle()
                }
            } label: {
                HStack {
                    Text(selectedDate.wrappedValue != nil ? dateFormatter.string(from: selectedDate.wrappedValue!) : placeholder)
                        .applyCertiFont(.caption_semibold_12)
                        .frame(height: 18)
                        .foregroundColor(selectedDate.wrappedValue != nil ? .grayscale600 : .grayscale300)
                        .padding(.leading, 12)
                    
                    Spacer()
                    
                    Image(.iconArrowdown24)
                        .foregroundColor(.secondary)
                        .padding(.trailing, 12)
                }
                .frame(width: 121, height: 40)
                .background(.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(.grayscale100, lineWidth: 1)
                )
            }
        }
    }
}

#Preview {
    PeriodInputComponent()
}
