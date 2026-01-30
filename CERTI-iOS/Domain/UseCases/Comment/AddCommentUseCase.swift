//
//  AddCommentUseCase.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 1/29/26.
//

import Foundation

protocol AddCommentUseCase {
    func execute(content: String, certificationId: Int) async -> Result<Void, NetworkError>
}

final class DefaultAddCommentUseCase: AddCommentUseCase {
    private let repository: CommentRepository
    
    init(repository: CommentRepository) {
        self.repository = repository
    }
    
    func execute(content: String, certificationId: Int) async -> Result<Void, NetworkError> {
        return await repository.addComment(content: content, certificationId: certificationId)
    }
}
