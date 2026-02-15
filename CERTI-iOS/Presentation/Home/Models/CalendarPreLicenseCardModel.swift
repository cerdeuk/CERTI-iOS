//
//  CalendarPreLicenseCardModel.swift
//  CERTI-iOS
//
//  Created by nayeon on 2/11/26.
//

struct CalendarPreLicenseCardModel: Identifiable {
    let certificationId: Int
    let location: String
    let time: String
    let title: String
    let category: String
    let description: String
    
    var id: Int {certificationId}
}
