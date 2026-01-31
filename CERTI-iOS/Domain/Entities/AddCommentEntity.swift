//
//  AddCommentEntity.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 1/31/26.
//

import Foundation

struct AddCommentEntity {
    let content: String
    let certificationId: Int
}


// MARK: - Func

extension AddCommentEntity {
    func toCommentRequestDTO() -> CommentRequestDTO {
        return CommentRequestDTO(content: content, certificationId: certificationId)
    }
}
