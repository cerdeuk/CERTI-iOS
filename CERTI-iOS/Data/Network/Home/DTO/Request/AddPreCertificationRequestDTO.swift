//
//  AddPreCertificationRequestDTO.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 1/30/26.
//

import Foundation

struct AddPreCertificationRequestDTO: Encodable {
    let certificationId : Int
    let city, state, testDate : String
}
