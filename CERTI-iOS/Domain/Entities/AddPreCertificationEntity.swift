//
//  AddPreCertificationEntity.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 1/30/26.
//

import Foundation

struct AddPreCertificationEntity {
    let certificationId : Int
    let city, state, testDate : String
}


// MARK: - Func

extension AddPreCertificationEntity{
    func toAddPreCertificationRequestDTO() -> AddPreCertificationRequestDTO {
        return AddPreCertificationRequestDTO(certificationId: certificationId, city: city, state: state, testDate: testDate)
    }
}
