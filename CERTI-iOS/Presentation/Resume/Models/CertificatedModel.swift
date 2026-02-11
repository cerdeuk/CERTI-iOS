//
//  CertificatedModel.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/10/25.
//

import SwiftUI

struct CertificatedModel: Identifiable, Decodable {
    var id: Int { acquisitionId }
    
    let certificationId: Int
    let acquisitionId: Int
    let cardFrontImageUrl: String
    let index: Int
    let name: String
    let tags: [String]
    let description: String
    let acquisitionDate: String
    let grade: String?
    let certificationType: String
}

extension CertificatedModel {    
    var displayacquisitionDate: String {
        acquisitionDate.toDisplayDateString()
    }
}
