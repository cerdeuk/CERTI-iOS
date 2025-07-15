//
//  RecommendCertificationResponseDTO.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/16/25.
//

import Foundation

typealias RecommendCertificationResponseDTO = BaseResponseDTO<RecommendCertificationData>

struct RecommendCertificationData: Decodable {
    let recommendationList: [RecommendCertification]
}

//struct RecommendCertification: Decodable, Identifiable {
//    let certificationId: Int
//    let certificationName: String
//    let certificationType: String
//    let testType: String
//    let tags: [String]
//    let recommendationScore: Int
//    let isFavorite: Bool
//
//    var id: Int { certificationId }
//}

// Identifiable 이 필요할까?
struct RecommendCertification: Decodable {
    let certificationId: Int
    let certificationName: String
    let certificationType: String
    let testType: String
    let tags: [String]
    let recommendationScore: Int
    let isFavorite: Bool
}
