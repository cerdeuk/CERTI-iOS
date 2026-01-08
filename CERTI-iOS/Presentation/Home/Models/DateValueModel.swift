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
