//
//  DeleteCommentUseCase.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 1/29/26.
//

import Foundation

protocol DeleteCommentUseCase {
    func execute(commentId: Int) async -> Result<Void, NetworkError>
}

final class DefaultDeleteCommentUseCase: DeleteCommentUseCase {
    private let repository: CommentRepository
    
    init(repository: CommentRepository) {
        self.repository = repository
    }
    
    func execute(commentId: Int) async -> Result<Void, NetworkError> {
        return await repository.deleteComment(commentId: commentId)
    }
}
