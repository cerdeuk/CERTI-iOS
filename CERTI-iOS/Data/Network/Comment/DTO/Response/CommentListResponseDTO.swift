//
//  CommentListResponseDTO.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 1/26/26.
//

import Foundation

typealias CommentListResponseDTO = BaseResponseDTO<CommentListData>

struct CommentListData : Decodable {
    let content: [CommentInfo]
    let totalPages, totalElements: Int
    let isLast: Bool
}

extension CommentListData {
    func toCommentEntity() -> CommentEntity {
        return CommentEntity(comments: content.map { $0.toCommentEntityData() },
                             totalPages: totalPages,
                             totalElements: totalElements,
                             isLast: isLast
        )
    }
}

struct CommentInfo: Decodable {
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
}

extension CommentInfo {
    func toCommentEntityData() -> CommentEntityData {
        return CommentEntityData(commentId: commentId,
                                 userId: userId,
                                 nickName: nickName,
                                 content: content,
                                 userMajor: userMajor,
                                 userJob: userJob,
                                 state: state,
                                 likeCount: likeCount,
                                 createdTime: createdTime,
                                lastModifiedTime: lastModifiedTime,
                                 isLike: isLike
        )
    }
}
