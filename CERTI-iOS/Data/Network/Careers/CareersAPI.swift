//
//  CareersAPI.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/17/25.
//

import Foundation

import Moya

enum CareersAPI {
    case fetchCareersList
    case deleteCareers(id: Int)
    case addCareer(request: AddCareerRequestDTO)
    case editCareer(request: EditCareerRequestDTO)
}

extension CareersAPI: BaseTargetType {
    var headerType: HeaderType {
        switch self {
        default:
            return .accessTokenHeader
        }
    }
    
    var path: String {
        switch self {
        case .fetchCareersList:
            return "careers"
        case .deleteCareers(let id):
            return "careers/\(id)"
        case .addCareer:
            return "careers"
        case .editCareer(let careerId):
            return "careers/\(careerId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchCareersList:
            return .get
        case .deleteCareers:
            return .delete
        case .addCareer:
            return .post
        case .editCareer:
            return .put
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchCareersList:
            return .requestPlain
        case .deleteCareers:
            return .requestPlain
        case .addCareer(let request):
            return .requestJSONEncodable(request)
        case .editCareer(let request):
            return .requestJSONEncodable(request)
        }
    }
    
    
}
