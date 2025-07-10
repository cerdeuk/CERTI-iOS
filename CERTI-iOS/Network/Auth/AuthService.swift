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

        // Moya 비동기 요청을 async/await와 호환되게 withCheckedContinuation으로 감싼다
        let rawResponse: Result<Response, MoyaError> = await withCheckedContinuation { continuation in
            provider.request(target) { result in
                continuation.resume(returning: result)
            }
        }

        switch rawResponse {
        case .success(let response):
            do {
                // 응답에서 data -> needSignUp 값을 먼저 추출
                let json = try JSONSerialization.jsonObject(with: response.data, options: []) as? [String: Any]
                let data = json?["data"] as? [String: Any]
                let needSignUp = data?["needSignUp"] as? Bool ?? false

                let decoder = JSONDecoder()

                if needSignUp {
                    let result = try decoder.decode(BaseResponseDTO<SignupRequiredResponseDTO>.self, from: response.data)
                    guard let data = result.data else {
                        return .failure(.decodingError)
                    }
                    return .success(.needSignUp(data))
                } else {
                    let result = try decoder.decode(BaseResponseDTO<LoginSuccessResponseDTO>.self, from: response.data)
                    guard let data = result.data else {
                        return .failure(.decodingError)
                    }
                    return .success(.success(data))
                }
            } catch {
                if let errorResponse = try? JSONDecoder().decode(ErrorResponseDTO.self, from: response.data) {
                    return .failure(.apiError(message: errorResponse.message))
                } else {
                    return .failure(.decodingError)
                }
            }

        case .failure(let moyaError):
            print("Moya error: \(moyaError.localizedDescription)")
            return .failure(.networkFail)
        }
    }
}
