//
//  CommentService.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 1/26/26.
//

import Foundation

import Moya

protocol CommentServiceProtocol {
    func getComment(certificationId: Int, page: Int, size: Int, commentSortType: String) async -> Result<CommentListResponseDTO, NetworkError>
    func addComment(request: CommentRequestDTO) async ->Result<Void, NetworkError>
    func deleteComment(commentId: Int) async ->Result<Void, NetworkError>
    func likeComment(commentId: Int) async -> Result<Void, NetworkError>
}

final class CommentService: BaseService, CommentServiceProtocol {
    private let provider = MoyaProvider<CommentAPI>.init(plugins: [MoyaPlugin()])
    
    func getComment(certificationId: Int, page: Int, size: Int, commentSortType: String) async -> Result<CommentListResponseDTO, NetworkError> {
        return await requestDecodable(provider, .getComment(certificationId: certificationId, page: page, size: size, commentSortType: commentSortType))
    }
    
    func addComment(request: CommentRequestDTO) async -> Result<Void, NetworkError> {
        return await requestVoid(provider, .addComment(request: request))
    }
    
    func deleteComment(commentId: Int) async -> Result<Void, NetworkError> {
        return await requestVoid(provider, .deleteComment(commentId: commentId))
    }
    
    func likeComment(commentId: Int) async -> Result<Void, NetworkError> {
        return await requestVoid(provider, .likeComment(commentId: commentId))
    }
}
