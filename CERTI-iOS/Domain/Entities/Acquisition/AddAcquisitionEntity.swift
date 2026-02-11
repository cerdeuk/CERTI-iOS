//
//  AddAcquisitionEntity.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 1/30/26.
//

import Foundation

struct AddAcquisitionEntity {
    let certificationId: Int
    
    init(certificationId: Int) {
        self.certificationId = certificationId
    }
}


// MARK: - Func

extension AddAcquisitionEntity{
    func toAddAcquisitionRequestDTO() -> AddAcquisitionRequestDTO {
        return AddAcquisitionRequestDTO(certificationId: certificationId)
    }
}
