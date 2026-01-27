//
//  CommentEntity.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 1/27/26.
//

import Foundation

struct CommentEntity {
    let comments: [CommentEntityData]
    
    init(comments: [CommentEntityData]) {
        self.comments = comments
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
