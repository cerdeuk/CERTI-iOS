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
    @Binding var isFilled: Bool
    @Binding var startAt: String
    @Binding var endAt: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .center, spacing: 0) {
                customDatePicker(
                    selectedDate: $startDate,
                    isExpanded: $isStartDateExpanded,
                    placeholder: "시작일"
                )
                .padding(.leading, 20)
                
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
                            let selected = $0
                            startDate = selected
                            startAt = formatDateToString(selected)
                            
                            if let end = endDate, selected > end {
                                endDate = selected
                                endAt = formatDateToString(selected)
                            }
                            
                            isFilled = startDate != nil && endDate != nil
                        }
                    ), displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .environment(\.locale, Locale(identifier: "ko_KR"))
                    .padding(.horizontal, 26)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.05), radius: 20, x: 4, y: 4)
                    .frame(maxWidth: .infinity)
                    .onChange(of: startDate) { newValue in
                        withAnimation(.easeInOut(duration: 0.2)) {
                            isStartDateExpanded = false
                            isFilled = startDate != nil && endDate != nil
                            if let selected = newValue {
                                startAt = formatDateToString(selected)
                            }
                        }
                    }
                }
                .padding(.leading, 20)
                .padding(.trailing, 55)
            } else if isEndDateExpanded {
                withAnimation(.easeInOut(duration: 0.2)) {
                    DatePicker("", selection: Binding<Date>(
                        get: { endDate ?? Date() },
                        set: {
                            let selected = $0
                            endDate = selected
                            endAt = formatDateToString(selected)
                            
                            if let start = startDate, selected < start {
                                startDate = selected
                                startAt = formatDateToString(selected)
                            }
                            
                            isFilled = startDate != nil && endDate != nil
                        }
                    ), displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .environment(\.locale, Locale(identifier: "ko_KR"))
                    .padding(.horizontal, 26)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.05), radius: 20, x: 4, y: 4)
                    .frame(maxWidth: .infinity)
                    .onChange(of: endDate) { newValue in
                        withAnimation(.easeInOut(duration: 0.2)) {
                            isEndDateExpanded = false
                            isFilled = startDate != nil && endDate != nil
                            if let selected = newValue {
                                endAt = formatDateToString(selected)
                            }
                        }
                    }
                }
                .padding(.leading, 20)
                .padding(.trailing, 55)
            }
        }
        .onAppear {
            datesBind()
        }
        .onChange(of: startAt) { _ in
            datesBind()
        }
        .onChange(of: endAt) { _ in
            datesBind()
        }
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }
    
    private func formatDateToString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
    
    private func datesBind() {
        startDate = startAt.isEmpty ? nil : Date.stringToDate(startAt)
        endDate = endAt.isEmpty ? nil : Date.stringToDate(endAt)
        isFilled = startDate != nil && endDate != nil
    }
}

extension PeriodInputComponent {
    private func customDatePicker(
        selectedDate: Binding<Date?>,
        isExpanded: Binding<Bool>,
        placeholder: String
    ) -> some View {
        VStack(alignment: .leading, spacing: 0) {
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
                HStack(alignment: .center, spacing: 0) {
                    Text(selectedDate.wrappedValue != nil ? formatDateToString(selectedDate.wrappedValue!) : placeholder)
                        .applyCertiFont(.caption_semibold_12)
                        .frame(width: 72,height: 18, alignment: .leading)
                        .foregroundColor(selectedDate.wrappedValue != nil ? .grayscale600 : .grayscale300)
                        .padding(.leading, 12)
                    
                    Spacer()
                    
                    Image(.iconArrowdown24)
                        .padding(.trailing, 12)
                }
                .frame(width: 121, height: 40)
                .background(.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(.grayscale100, lineWidth: 1)
                )
            }
        }
    }
}
