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
    @ObservedObject var viewModel: HomeViewModel
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
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
        .task(id: viewModel.currentMonth) {
            await viewModel.getMonthlyPreCertification()
        }
    }
}

extension HomeCalendarView {
    private var calendarHeader: some View {
        HStack(alignment: .center, spacing: 0) {
            Text("\(viewModel.getYearAndMonthString(currentDate: viewModel.getCurrentMonth())[0]) \(viewModel.getYearAndMonthString(currentDate: viewModel.getCurrentMonth())[1])")
                .applyCertiFont(.body_semibold_16)
                .foregroundStyle(.black)
                .frame(height: 22)
            
            Spacer()
            
            Button {
                withAnimation {
                    viewModel.currentMonth -= 1
                }

            } label: {
                Image(.iconCalendarArrowLeft)
                    .frame(width: 16, height: 16)
            }
            .padding(.trailing, 21)
            
            Button {
                viewModel.currentMonth += 1
            } label: {
                Image(.iconCalendarArrowRight)
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
            ForEach(viewModel.extractDate()) { value in
                CalendarView(value: value, state: viewModel.dayState(for: value), hasTodo: viewModel.hasPreLicenses(on: value.date))
                    .background {
                        Circle()
                            .fill(viewModel.isSameDay(day1: value.date, day2: today) ? .grayscale100 : .mainblue)
                            .frame(width: 30,height: 30)
                            .opacity(viewModel.isSameDay(day1: value.date, day2: viewModel.currentDate)||viewModel.isSameDay(day1: value.date, day2: today) ? 1 : 0)
                    }
                    .onTapGesture {
                        viewModel.currentDate = value.date
                    }
            }
        }
    }
}
