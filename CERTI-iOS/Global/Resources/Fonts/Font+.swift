//
//  Font+.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/4/25.
//

import SwiftUI

extension Font {
    enum Pretend {
        case bold, semibold, regular
        
        var value: String {
            switch self {
            case .bold:
                return "Pretendard-Bold"
            case .semibold:
                return "Pretendard-SemiBold"
            case .regular:
                return "Pretendard-Regular"
            }
        }
    }
    
    static func pretend(type: Pretend, size: CGFloat) -> Font {
        return .custom(type.value, size: size)
    }
    
    static let title_bold_24 = pretend(type: .bold, size: 24)
    static let title_bold_22 = pretend(type: .bold, size: 22)

    static let sub_bold_20 = pretend(type: .bold, size: 20)
    static let sub_semibold_20 = pretend(type: .semibold, size: 20)

    static let body_bold_18 = pretend(type: .bold, size: 18)
    static let body_semibold_18 = pretend(type: .semibold, size: 18)
    static let body_bold_16 = pretend(type: .bold, size: 16)
    static let body_regular_16 = pretend(type: .regular, size: 16)
    static let body_semibold_16 = pretend(type: .semibold, size: 16)

    static let caption_bold_14 = pretend(type: .bold, size: 14)
    static let caption_semibold_14 = pretend(type: .semibold, size: 14)
    static let caption_regular_14 = pretend(type: .regular, size: 14)
    static let caption_semibold_12 = pretend(type: .semibold, size: 12)
    static let caption_regular_12 = pretend(type: .regular, size: 12)
}
