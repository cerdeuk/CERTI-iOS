//
//  TokenRefreshService.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/5/25.
//

import Foundation

import Moya

protocol TokenRefreshServiceProtocol {
    func refresh() async -> Result<TokenResponseDTO, NetworkError>
}

final class TokenRefreshService: BaseService<AuthAPI>, TokenRefreshServiceProtocol {
    func refresh() async -> Result<TokenResponseDTO, NetworkError> {
        return await requestDecodable(.refresh)
    }
}
