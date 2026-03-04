//
//  String+.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/10/25.
//

import Foundation

extension String {
    var antiAppleBySangyup: Self {
        self.map({ String($0) }).joined(separator: "\u{200B}")
    }
    
    /// 문자열을 금액 형태로 바꿔주는 함수
    func convertPrice(maxPrice: Int) -> String {
        // 숫자만 남기기
        let filteredPrice = self.filter { $0.isNumber }
        guard let price = Int(filteredPrice) else { return "" }
        
        // 최대 금액 제한
        let limitedPrice = min(price, maxPrice)
        
        // 숫자를 3자리마다 쉼표로 구분
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: limitedPrice as NSNumber) ?? ""
    }
    
    /// 금액 형태의 문자열을 정수로 바꿔주는 함수
    func convertInt() -> Int {
        // 숫자만 남기기
        let filteredPrice = self.filter { $0.isNumber }
        guard let price = Int(filteredPrice) else { return 0 }
        
        return price
    }
    
    var isBlank: Bool {
        return self.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    func toDisplayDateString() -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy.MM.dd"
        inputFormatter.locale = Locale(identifier: "ko_KR")
        
        guard let date = inputFormatter.date(from: self) else {
            return self
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.locale = Locale(identifier: "ko_KR")
        outputFormatter.dateFormat = "yyyy년 M월 d일"
        
        return "\(outputFormatter.string(from: date))"
    }
    
    func convertToDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "ko_KR")
        
        return formatter.date(from: self)
    }
    
    func toUIDateString() -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy.MM.dd"
        inputFormatter.locale = Locale(identifier: "ko_KR")
        
        guard let date = inputFormatter.date(from: self) else {
            return self
        }

        let outputFormatter = DateFormatter()
        outputFormatter.locale = Locale(identifier: "ko_KR")
        outputFormatter.dateFormat = "yyyy. MM. dd"

        return "\(outputFormatter.string(from: date))"
    }
    
    func toCommentDateString() -> String {
            let inputFormatter = DateFormatter()
            inputFormatter.locale = Locale(identifier: "ko_KR")
            inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
            
            guard let date = inputFormatter.date(from: self) else {
                return self
            }
            
            let outputFormatter = DateFormatter()
            outputFormatter.locale = Locale(identifier: "ko_KR")
            outputFormatter.dateFormat = "yyyy.MM.dd"
            
            return outputFormatter.string(from: date)
        }
    
    func toBirthDateString() -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        inputFormatter.locale = Locale(identifier: "ko_KR")
        
        guard let birthDate = inputFormatter.date(from: self) else {
            return self
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy. MM. dd"
        outputFormatter.locale = Locale(identifier: "ko_KR")
        
        let formattedDate = outputFormatter.string(from: birthDate)
        
        let calendar = Calendar(identifier: .gregorian)
        let today = Date()
        
        var age = calendar.dateComponents([.year], from: birthDate, to: today).year ?? 0
        
        let birthdayThisYear = calendar.date(
            bySetting: .year,
            value: calendar.component(.year, from: today),
            of: birthDate
        )!
        
        if today < birthdayThisYear {
            age -= 1
        }
        
        return "\(formattedDate) (만 \(age)세)"
    }
    
    func trimmedUsername() -> String {
        if self.count <= 3 {
            return self
        } else {
            return "\(self.prefix(3))..."
        }
    }
    
    func trimmedString(count: Int) -> String {
        if self.count <= count {
            return self
        } else {
            return "\(self.prefix(count))..."
        }
    }

    func toHHmm() -> String {
        let input = DateFormatter()
        input.locale = Locale(identifier: "ko_KR")
        input.timeZone = TimeZone(identifier: "Asia/Seoul")
        input.dateFormat = "yyyy-MM-dd'T'HH:mm"
        
        guard let date = input.date(from: self) else { return "" }
        
        let output = DateFormatter()
        output.locale = Locale(identifier: "ko_KR")
        output.dateFormat = "HH:mm"
        return output.string(from: date)
    }
    
    func toYearMonth() -> String {
        let toDateFormatter = DateFormatter()
        toDateFormatter.locale = Locale(identifier: "ko_KR")
        toDateFormatter.dateFormat = "yyyy.MM.dd"
        
        let yearMonthFormatter = DateFormatter()
        yearMonthFormatter.locale = Locale(identifier: "ko_KR")
        yearMonthFormatter.dateFormat = "yyyy.MM"
        
        guard let date = toDateFormatter.date(from: self) else {
            return self
        }
        
        return yearMonthFormatter.string(from: date)
    }
}
