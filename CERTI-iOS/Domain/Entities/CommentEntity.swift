//
//  CommentEntity.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 1/27/26.
//

import Foundation

struct CommentEntity {
    let comments: [CommentEntityData]
    let totalPages: Int
    let totalElements: Int
    let isLast: Bool
    
    init(comments: [CommentEntityData], totalPages: Int, totalElements: Int, isLast: Bool) {
        self.comments = comments
        self.totalPages = totalPages
        self.totalElements = totalElements
        self.isLast = isLast
    }
}


// MARK: - Func

extension CommentEntity {
    func toPaginationCommentModel() -> PaginationCommentModel {
        PaginationCommentModel(totalPages: totalPages,
                               totalElements: totalElements,
                               isLast: isLast,
                               content: comments.map { $0.toComment() }
        )
    }
}

struct CommentEntityData {
    let commentId: Int
    let userId: Int
    let nickName: String
    let content: String
    let userMajor: String
    let userJob: String
    let state: String
    let likeCount: Int
    let createdTime: String
    let lastModifiedTime: String
    let isLike: Bool
    
    init(commentId: Int, userId: Int, nickName: String, content: String, userMajor: String, userJob: String, state: String, likeCount: Int, createdTime: String, lastModifiedTime: String, isLike: Bool) {
        self.commentId = commentId
        self.userId = userId
        self.nickName = nickName
        self.content = content
        self.userMajor = userMajor
        self.userJob = userJob
        self.state = state
        self.likeCount = likeCount
        self.createdTime = createdTime
        self.lastModifiedTime = lastModifiedTime
        self.isLike = isLike
    }
}

extension CommentEntityData {
    func toComment() -> Comment {
        Comment(
            commentId: commentId,
            userId: userId,
            nickName: nickName,
            content: content,
            userMajor: userMajor,
            userJob: userJob,
            state: state,
            createdTime: createdTime,
            lastModifiedTime: lastModifiedTime,
            isLike: isLike,
            likeCount: likeCount
        )
    }
}
