//
//  DateValueModel.swift
//  CERTI-iOS
//
//  Created by 김나연 on 12/18/25.
//

import SwiftUI

struct DateValueModel: Identifiable {
    var id = UUID().uuidString
    var day: Int
    var date: Date
    let isCurrentMonth: Bool
}

extension DateValueModel {
    func state(today: Date, selectedDate: Date) -> CalendarDayState {
        if !isCurrentMonth {
            return .otherMonth
        }
        
        let isToday = Calendar.current.isDate(date, inSameDayAs: today)
        let isSelected = Calendar.current.isDate(date, inSameDayAs: selectedDate)
        
        switch (isToday, isSelected) {
        case (true, true):
            return .todaySelected
        case (true, false):
            return .today
        case (false, true):
            return .selected
        default:
            return .normal
        }
    }
}
