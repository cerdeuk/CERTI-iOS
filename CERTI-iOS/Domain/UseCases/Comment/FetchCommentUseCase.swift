//
//  FetchCommentUseCase.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 1/27/26.
//

import Foundation

protocol FetchCommentUseCase {
    func execute(certificationId: Int, page: Int, size: Int, sort: String) async -> Result<CommentEntity, NetworkError>
}

final class DefaultFetchCommentUseCase: FetchCommentUseCase {
    private let repository: CommentRepository
    
    init(repository: CommentRepository) {
        self.repository = repository
    }
    
    func execute(certificationId: Int, page: Int, size: Int, sort: String) async -> Result<CommentEntity, NetworkError> {
        return await repository.getComment(certificationId: certificationId, page: page, size: size, sort: sort)
    }
}
