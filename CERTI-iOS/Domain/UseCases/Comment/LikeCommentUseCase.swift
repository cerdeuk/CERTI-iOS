//
//  LikeCommentUseCase.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 1/29/26.
//

import Foundation

protocol LikeCommentUseCase {
    func execute(commentId: Int) async -> Result<Void, NetworkError>
}

final class DefaultLikeCommentUseCase: LikeCommentUseCase {
    private let repository: CommentRepository
    
    init(repository: CommentRepository) {
        self.repository = repository
    }
    
    func execute(commentId: Int) async -> Result<Void, NetworkError> {
        return await repository.likeComment(commentId: commentId)
    }
}
