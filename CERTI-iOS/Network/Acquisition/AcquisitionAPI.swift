//
//  AcquisitionAPI.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/16/25.
//

import Foundation

import Moya

enum AcquisitionAPI {
    case fetchAcquisitionList
    case fetchAcquisitionDetail(id: Int)
    case deleteAcquisition(id: Int)
}

extension AcquisitionAPI: BaseTargetType {
    var headerType: HeaderType {
        switch self {
        default:
            return .accessTokenHeader
        }
    }
    
    var path: String {
        switch self {
        case .fetchAcquisitionList:
            return "acquisition"
        case .fetchAcquisitionDetail(let id):
            return "acquisition/\(id)"
        case .deleteAcquisition(let id):
            return "acquisition/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchAcquisitionList:
            return .get
        case .fetchAcquisitionDetail:
            return .get
        case .deleteAcquisition:
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchAcquisitionList:
            return .requestPlain
        case .fetchAcquisitionDetail:
            return .requestPlain
        case .deleteAcquisition:
            return .requestPlain
        }
    }
    
    
}
