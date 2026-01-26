//
//  CommentService.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 1/26/26.
//

import Foundation

import Moya

protocol CommentServiceProtocol {
    func getComment() async -> Result<CommentListResponseDTO, NetworkError>
}

final class CommentService: BaseService, CommentServiceProtocol {
    private let provider = MoyaProvider<CommentAPI>.init(plugins: [MoyaPlugin()])
    
    func getComment() async -> Result<CommentListResponseDTO, NetworkError> {
        return await requestDecodable(provider, .getComment)
    }
}
