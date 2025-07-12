//
//  AuthService.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/10/25.
//

import Moya
import Foundation

enum AuthResponse {
    case success(LoginSuccessResponseDTO)
    case needSignUp(SignupRequiredResponseDTO)
}

protocol AuthServiceProtocol {
    func login(type: SocialLoginType, authorizationCode: String) async -> Result<AuthResponse, NetworkError>
}

final class AuthService: BaseService, AuthServiceProtocol {
    private let provider = MoyaProvider<AuthAPI>.init(plugins: [MoyaPlugin()])
    
    func login(type: SocialLoginType, authorizationCode: String) async -> Result<AuthResponse, NetworkError> {
        let target = AuthAPI.login(type: type, code: authorizationCode)
        
        let rawResponse: Result<Response, MoyaError> = await withCheckedContinuation { continuation in
            provider.request(target) { result in
                continuation.resume(returning: result)
            }
        }
        
        switch rawResponse {
        case .success(let response):
            do {
                let decoder = JSONDecoder()
                switch response.statusCode {
                case 201:
                    let result = try decoder.decode(BaseResponseDTO<LoginSuccessResponseDTO>.self, from: response.data)
                    guard let data = result.data else {
                        return .failure(.decodingError)
                    }
                    return .success(.success(data))
                case 200:
                    let result = try decoder.decode(BaseResponseDTO<SignupRequiredResponseDTO>.self, from: response.data)
                    guard let data = result.data else {
                        return .failure(.decodingError)
                    }
                    return .success(.needSignUp(data))
                case 400:
                    return .failure(.badRequest)
                case 401:
                    let refreshResult = await TokenRefresher.shared.refresh()
                    switch refreshResult {
                    case .success:
                        return await login(type: type, authorizationCode: authorizationCode)
                    case .failure:
                        return .failure(.unauthorized)
                    }
                case 404:
                    return .failure(.notFound)
                case 409:
                    if let errorResponse = try? decoder.decode(ErrorResponseDTO.self, from: response.data) {
                        return .failure(.apiError(message: errorResponse.message))
                    } else {
                        return .failure(.badRequest)
                    }
                case 500...599:
                    return .failure(.internalServerError)
                default:
                    return .failure(.networkFail)
                }
            } catch {
                return .failure(.decodingError)
            }
            
        case .failure(let moyaError):
            print("Moya error: \(moyaError.localizedDescription)")
            return .failure(.networkFail)
        }
    }
}
