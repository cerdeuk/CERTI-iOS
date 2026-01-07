//
//  HomeCalendarView.swift
//  CERTI-iOS
//
//  Created by 김나연 on 11/29/25.
//

import SwiftUI

enum CalendarDayState {
    case today
    case selected
    case todaySelected
    case normal
    case otherMonth
}

struct HomeCalendarView: View {
//    @ObservedObject var viewModel: HomeViewModel
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    // 너도! dkfo enro
    @State private var currentDate: Date = .distantPast
    @State private var currentMonth: Int = 0
    private let today = Date()
    
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
        .onChange(of: currentMonth) { _ in
        }
    }
}

extension HomeCalendarView {
    private var calendarHeader: some View {
        HStack(alignment: .center, spacing: 0) {
//            Text("\(viewModel.getYearAndMonthString(currentDate: viewModel.currentDate)[0]) \(viewModel.getYearAndMonthString(currentDate: viewModel.currentDate)[1])")
            // 너도 뷰 모델 뜨면 위에걸로 바꿔라잉
            Text("\(getYearAndMonthString(currentDate: getCurrentMonth())[0]) \(getYearAndMonthString(currentDate: getCurrentMonth())[1])")
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
                currentMonth += 1
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
                    .background {
                        Circle()
                            .fill(isSameDay(day1: value.date, day2: today) ? .grayscale100 : .mainblue)
                            .frame(width: 30,height: 30)
                            .opacity(isSameDay(day1: value.date, day2: currentDate)||isSameDay(day1: value.date, day2: today) ? 1 : 0)
                    }
                    .onTapGesture {
                        currentDate = value.date
                    }
            }
        }
    }
    
//    private var
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
        
        let currentMonthDays = currentMonth.getAllDates().compactMap { date -> DateValueModel in
            let day = calendar.component(.day, from: date)
            return DateValueModel(day: day, date: date, isCurrentMonth: true)
        }
        
        var days = currentMonthDays
        
        let firstWeekday = calendar.component(.weekday, from: currentMonthDays.first!.date)
        
        if let prevMonth = calendar.date(byAdding: .month, value: -1, to: currentMonth) {
            let prevMonthDays = prevMonth.getAllDates()
            let prefixDays = prevMonthDays.suffix(firstWeekday - 1)
            
            let prevMonthValues = prefixDays.map { date in
                DateValueModel(day: calendar.component(.day, from: date), date: date, isCurrentMonth: false)
            }
            days.insert(contentsOf: prevMonthValues, at: 0)
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
        let state = value.state(today: today, selectedDate: currentDate)
        let hasTodo = tasks.contains { isSameDay(day1: $0.todoDate, day2: value.date) }

        Text("\(value.day)")
            .applyCertiFont(.caption_regular_14)
            .foregroundStyle(textColor(for: state))
            .background {
                Circle()
                    .fill(backgroundColor(for: state))
                    .frame(width: 30, height: 30)
                    .opacity(state == .selected || state == .todaySelected ? 1 : 0)
            }
            .overlay(alignment: .topTrailing) {
                if hasTodo && state != .today && state != .selected {
                    Circle()
                        .fill(.purpleblue)
                        .frame(width: 5, height: 5)
                        .offset(x: 7, y: -4)
                }
            }
    }
    
    func textColor(for state: CalendarDayState) -> Color {
        switch state {
        case .selected, .todaySelected:
            return .white
        case .otherMonth:
            return .grayscale200
        default:
            return .black
        }
    }

    func backgroundColor(for state: CalendarDayState) -> Color {
        switch state {
        case .today:
            return .grayscale100
        case .selected, .todaySelected:
            return .mainblue
        default:
            return .clear
        }
    }
    
    func isSameDay(day1: Date, day2: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(day1, inSameDayAs: day2)
    }
}

#Preview {
    HomeCalendarView()
}
