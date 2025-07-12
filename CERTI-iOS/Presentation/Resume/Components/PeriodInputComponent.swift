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
        ZStack {
            HStack(spacing: 0) {
                customDatePicker(
                    selectedDate: $startDate,
                    isExpanded: isStartDateExpanded,
                    placeholder: "시작일"
                )
                
                Text("부터")
                    .applyCertiFont(.caption_semibold_14)
                    .foregroundStyle(.grayscale600)
                    .frame(width: 25, height: 20)
                    .padding(.leading, 8)
                    .padding(.trailing, 10)
                
                customDatePicker(
                    selectedDate: $endDate,
                    isExpanded: isEndDateExpanded,
                    placeholder: "종료일"
                )
                
                Text("까지")
                    .applyCertiFont(.caption_semibold_14)
                    .foregroundStyle(.grayscale600)
                    .frame(width: 25, height: 20)
                    .padding(.leading, 8)
            }
            
            if isStartDateExpanded || isEndDateExpanded {
                Color.blackOpacity40
                    .ignoresSafeArea()
                    .onTapGesture {
                        isStartDateExpanded = false
                        isEndDateExpanded = false
                    }
                
                VStack {
                    Spacer()
                    
                    DatePicker("", selection: Binding(
                        get: {
                            if isStartDateExpanded {
                                return startDate ?? Date()
                            } else {
                                return endDate ?? Date()
                            }
                        },
                        set: { newDate in
                            if isStartDateExpanded {
                                startDate = newDate
                                
                                if let endDate = endDate, newDate > endDate {
                                    self.endDate = newDate
                                }
                            } else {
                                endDate = newDate
                                
                                if let startDate = startDate, newDate < startDate {
                                    self.startDate = newDate
                                }
                            }
                        }
                    ), displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .environment(\.locale, Locale(identifier: "ko_KR"))
                    .padding()
                    .background(.white)
                    .cornerRadius(16)
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
                    .padding(.horizontal, 20)
                    .onChange(of: startDate) { _ in
                        if isStartDateExpanded {
                            isStartDateExpanded = false
                        }
                    }
                    .onChange(of: endDate) { _ in
                        if isEndDateExpanded {
                            isEndDateExpanded = false
                        }
                    }
                    
                    Spacer()
                }
                .transition(.opacity.combined(with: .scale))
            }
        }
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
        isExpanded: Bool,
        placeholder: String
    ) -> some View {
        Button {
            if placeholder == "시작일" {
                isEndDateExpanded = false
                isStartDateExpanded.toggle()
            } else {
                isStartDateExpanded = false
                isEndDateExpanded.toggle()
            }
        } label: {
            HStack(spacing: 0) {
                Text(selectedDate.wrappedValue != nil ? dateFormatter.string(from: selectedDate.wrappedValue!) : placeholder)
                    .applyCertiFont(.caption_semibold_12)
                    .frame(width:66, height: 18, alignment: .leading)
                    .foregroundColor(selectedDate.wrappedValue != nil ? .grayscale600 : .grayscale300)
                    .padding(.leading, 12)
                
                Spacer()
                
                Image(.iconArrowdown24)
                    .frame(width: 24, height: 24)
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

#Preview {
    PeriodInputComponent()
}
