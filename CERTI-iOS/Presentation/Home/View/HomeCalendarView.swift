//
//  HomeCalendarView.swift
//  CERTI-iOS
//
//  Created by 김나연 on 11/29/25.
//

import SwiftUI

struct HomeCalendarView: View {
//    @ObservedObject var viewModel: HomeViewModel
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    // 너도! dkfo enro
    @State private var currentDate: Date = Date()
    @State private var currentMonth: Int = 0
    
    private let days: [String] = ["일", "월", "화", "수", "목", "금", "토"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            calendarHeader
            weekDaysView
                .padding(.top, 12)
            calendarMainView
                .padding(.top, 16)
        }
        .padding(.horizontal, 20)
        .onChange(of: currentMonth) { newValue in
            currentDate = getCurrentMonth()
        }
    }
}

extension HomeCalendarView {
    private var calendarHeader: some View {
        HStack(alignment: .center, spacing: 0) {
//            Text("\(viewModel.getYearAndMonthString(currentDate: viewModel.currentDate)[0]) \(viewModel.getYearAndMonthString(currentDate: viewModel.currentDate)[1])")
            // 너도 뷰 모델 뜨면 위에걸로 바꿔라잉
            Text("\(getYearAndMonthString(currentDate: currentDate)[0]) \(getYearAndMonthString(currentDate: currentDate)[1])")
                .applyCertiFont(.body_semibold_16)
                .foregroundStyle(.black)
                .frame(height: 22)
            
            Spacer()
            
            Button {
                withAnimation {
                    currentMonth -= 1
                }

            } label: {
                Image(.iconCalendarArrowRight)
                    .frame(width: 16, height: 16)
            }
            .padding(.trailing, 21)
            
            Button {
                withAnimation {
                    currentMonth += 1
                }
            } label: {
                Image(.iconCalendarArrowLeft)
                    .frame(width: 16, height: 16)
            }
        }
    }
    
    private var weekDaysView: some View {
        HStack(alignment: .center, spacing: 0) {
            ForEach(days, id: \.self) { day in
                Text(day)
                    .applyCertiFont(.caption_regular_14)
                    .foregroundStyle(.grayscale400)
                    .frame(height: 36)
                    .frame(maxWidth: .infinity)
            }
        }
    }
    
    private var calendarMainView: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(extractDate()) { value in
                CardView(value: value)
            }
        }
    }
}

// 뷰모델 플뷰에 넣기 싫어서.. 추후에 삭제할것
extension HomeCalendarView {
    func getYearAndMonthString(currentDate: Date) -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월"
        formatter.locale = Locale(identifier: "ko_kr")
        let date = formatter.string(from: currentDate)
        return date.components(separatedBy: " ")
    }
    
    func extractDate() -> [DateValueModel] {
        let calendar = Calendar.current
        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap { date -> DateValueModel in
            let day = calendar.component(.day, from: date)
            return DateValueModel(day: day, date: date)
        }
        
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday - 1 {
            days.insert(DateValueModel(day: -1, date: Date()), at: 0)
        }
        
        return days
    }
    
    func getCurrentMonth() -> Date {
        let calendar = Calendar.current
        
        // 현재 달 가져오기
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else {
            return Date()
        }
        
        return currentMonth
    }
    
    @ViewBuilder
    func CardView(value: DateValueModel) -> some View {
        VStack(spacing: 0) {
            if value.day != -1 {
                Text("\(value.day)")
                    .applyCertiFont(.caption_regular_14)
                    .foregroundStyle(.black)
            }
        }
    }
}

#Preview {
    HomeCalendarView()
}
