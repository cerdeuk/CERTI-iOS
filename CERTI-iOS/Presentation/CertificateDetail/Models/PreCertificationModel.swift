//
//  PreCertificationModel.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 1/30/26.
//

import Foundation

struct PreCertificationModel: Decodable {
    var certificationId : Int
    var city, state, testDate : String?
}


// MARK: - Func

extension PreCertificationModel {
    func toPreCertificationEntity() -> AddPreCertificationEntity {
        return AddPreCertificationEntity(certificationId: certificationId, city: city ?? "", state: state ?? "", testDate: testDate ?? "")
    }
}
