//
//  Date+.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 1/23/26.
//

import Foundation

extension Date {
    static func stringToDate(_ value: String) -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        
        let formats = [
            "yyyy.MM.dd",
            
            // TODO: - 서버에서 연,월,일 주면 삭제
            "yyyy.MM"
        ]
        
        for format in formats {
            formatter.dateFormat = format
            if let date = formatter.date(from: value) {
                return date
            }
        }
        
        return nil
    }
}
