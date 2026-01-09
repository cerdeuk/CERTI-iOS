//
//  TokenRefreshService.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/9/26.
//

import Foundation

import Moya

typealias TokenResponseDTO = BaseResponseDTO<TokenResponseData>

protocol TokenRefreshServiceProtocol {
    func refresh() async -> Result<TokenResponseDTO, NetworkError>
}

final class TokenRefreshService: BaseService, TokenRefreshServiceProtocol {
    private let provider = MoyaProvider<AuthAPI>(plugins: [MoyaPlugin()])

    func refresh() async -> Result<TokenResponseDTO, NetworkError> {
        return await requestDecodable(provider, .refresh)
    }
}
