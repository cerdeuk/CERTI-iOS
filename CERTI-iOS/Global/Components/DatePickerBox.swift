//
//  DatePickerBox.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 12/2/25.
//

import SwiftUI

struct DatePickerBox: View {
    @State private var isCalendarVisible: Bool = false
    
    @Binding var selectedDate: Date?
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }
    private var today: Date {
        Calendar.current.startOfDay(for: Date())
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button {
                withAnimation(.easeInOut(duration: 0.2)){
                    isCalendarVisible.toggle()
                }
            } label: {
                HStack(alignment: .center, spacing: 0) {
                    if let date = selectedDate {
                        Text(dateFormatter.string(from: date))
                            .applyCertiFont(.caption_regular_14)
                            .foregroundStyle(.black)
                    } else {
                        Text("시험 날짜를 선택해주세요.")
                            .applyCertiFont(.caption_semibold_12)
                            .foregroundStyle(.grayscale300)
                    }
                    
                    Spacer()
                    
                    Image(.iconArrowdown24)
                        .foregroundStyle(.grayscale400)
                }
                .padding(.vertical, 11)
                .padding(.leading, 12)
                .padding(.trailing, 8)
            }
            .frame(height: 40)
            .background(.clear)
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(.grayscale200, lineWidth: 1)
            )
            .padding(.horizontal, 20)
            
            if isCalendarVisible {
                DatePicker("", selection: Binding<Date>(
                    get: { selectedDate ?? Date() },
                    set: {
                        selectedDate = $0
                        withAnimation {
                            self.isCalendarVisible = false
                        }
                    }
                ), in: today..., displayedComponents: .date)
                .datePickerStyle(.graphical)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.white)
                        .shadow(color: .black.opacity(0.08), radius: 12, x: 4, y: 4)
                )
                .environment(\.locale, Locale(identifier: "ko_KR"))
                .padding(.horizontal, 8)
                .padding(.top, 11)
            }
        }
        
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var selectedDate: Date? = nil
        
        var body: some View {
            VStack {
                HStack(alignment: .center, spacing: 0) {
                    Image(.iconCheck24)
                        .frame(width: 24, height: 24)
                    
                    Text("시험 날짜")
                        .applyCertiFont(.body_semibold_16)
                        .foregroundStyle(.grayscale600)
                        .frame(height: 22)
                }
                DatePickerBox(selectedDate: $selectedDate)
            }
        }
    }
    return PreviewWrapper()
}
