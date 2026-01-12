//
//  Date+.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/13/26.
//

import Foundation

extension Date {
    func toServerFormatString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: self)
    }
}
