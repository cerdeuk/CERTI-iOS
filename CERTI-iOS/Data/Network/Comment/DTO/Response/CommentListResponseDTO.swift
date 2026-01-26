//
//  CommentListResponseDTO.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 1/26/26.
//

import Foundation

typealias CommentListResponseDTO = BaseResponseDTO[CommentListData]

struct CommentListData : Decodable {
    let data: [CommentInfo]
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
