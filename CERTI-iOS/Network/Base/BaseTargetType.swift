//
//  BaseTargetType.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/1/25.
//

import Foundation

import Moya

enum HeaderType {
    case noneHeader
    case accessTokenHeader
    case refreshTokenHeader
}

protocol BaseTargetType: TargetType {
    var headerType: HeaderType { get }
}

extension BaseTargetType {
    
    var baseURL: URL {
        guard let urlString = Bundle.main.infoDictionary?["BASE_URL"] as? String,
              let url = URL(string: urlString) else {
            fatalError("🚨Base URL을 찾을 수 없습니다🚨")
        }
        return url
    }
    
    var headers: [String: String]? {
        var headers: [String: String] = [
            "Content-Type": "application/json"
        ]
        
        switch headerType {
        case .noneHeader:
            return nil
            
        case .accessTokenHeader:
            if case .success(let token) = TokenManager.shared.getAccessToken() {
                headers["Authorization"] = "Bearer \(token)"
            }
            return headers
            
        case .refreshTokenHeader:
            if case .success(let token) = TokenManager.shared.getRefreshToken() {
                headers["Authorization"] = "refreshToken=\(token)"
            }
            return headers
        }
    }
    
}
