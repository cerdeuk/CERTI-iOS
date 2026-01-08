//
//  CalendarView.swift
//  CERTI-iOS
//
//  Created by 김나연 on 1/7/26.
//

import SwiftUI

struct CalendarView: View {
    let value: DateValueModel
    let state: CalendarDayState
    let hasTodo: Bool

    var body: some View {
        Text("\(value.day)")
            .applyCertiFont(.caption_regular_14)
            .foregroundStyle(textColor)
            .background {
                Circle()
                    .fill(backgroundColor)
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

    private var textColor: Color {
        switch state {
        case .otherMonth:
            return .grayscale200
        default:
            return .black
        }
    }

    private var backgroundColor: Color {
        switch state {
        case .today:
            return .grayscale100
        case .selected, .todaySelected:
            return .mainblue
        default:
            return .clear
        }
    }
}
