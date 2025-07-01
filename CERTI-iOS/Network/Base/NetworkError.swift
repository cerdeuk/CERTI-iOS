//
//  NetworkError.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/1/25.
//

import Foundation

enum NetworkError: LocalizedError {
    case apiError(message: String)
    case badRequest
    case unauthorized
    case notFound
    case internalServerError
    case decodingError
    case networkFail
    
    var errorDescription: String? {
        switch self {
        case .apiError(let message):
            return message
        case .badRequest:
            return "잘못된 요청입니다"
        case .unauthorized:
            return "인증이 필요합니다"
        case .notFound:
            return "리소스를 찾을 수 없습니다"
        case .internalServerError:
            return "서버 오류가 발생했습니다"
        case .decodingError:
            return "데이터 변환 중 오류가 발생했습니다"
        case .networkFail:
            return "네트워크 연결에 실패했습니다"
        }
    }
}
