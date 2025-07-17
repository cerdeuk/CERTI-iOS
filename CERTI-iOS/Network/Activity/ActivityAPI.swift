//
//  ActivityAPI.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/17/25.
//

import Foundation

import Moya

enum ActivityAPI {
    case fetchActivityList
    case addActivity(request: AddActivityRequestDTO)
    case deleteActivity(id: Int)
}

extension ActivityAPI: BaseTargetType {
    var headerType: HeaderType {
        switch self {
        default:
            return .accessTokenHeader
        }
    }
    
    var path: String {
        switch self {
        case .fetchActivityList:
            return "activity"
        case .addActivity:
            return "activity"
        case .deleteActivity(let id):
            return "activity/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchActivityList:
            return .get
        case .addActivity:
            return .post
        case .deleteActivity:
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchActivityList:
            return .requestPlain
        case .addActivity(let request):
            return .requestJSONEncodable(request)
        case .deleteActivity:
            return .requestPlain
        }
    }
    
    
}
