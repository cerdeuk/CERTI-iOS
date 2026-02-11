//
//  CommentModel.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 1/9/26.
//

import Foundation

struct Comment: Identifiable, Decodable {
    let commentId: Int
    let userId: Int
    let nickName: String?
    let content: String
    let userMajor: String
    let userJob: String
    let state: String
    let createdTime: String
    let lastModifiedTime: String
    var isLike: Bool
    var likeCount: Int
    
    var id: Int { commentId }
}

struct PaginationCommentModel: Identifiable {
    let totalPages: Int
    let totalElements: Int
    let isLast: Bool
    let content: [Comment]
    
    var id: Int { totalPages }
}

