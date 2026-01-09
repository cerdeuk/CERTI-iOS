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
    let nickName: String
    let content: String
    let userMajor: String
    let userJob: String
    let state: String
    let likeCount: Int
    let createdTime: Date
    let lastModifiedTime: Date
    var isLike: Bool
    
    var id: Int { commentId }
}

struct PaginationCommentModel: Identifiable {
  let page: Int
  let isLast: Bool
  let comments: [Comment]
    
  var id: Int { page }
}

extension PaginationCommentModel {
    static func dummy() -> [PaginationCommentModel] {
        let calendar = Calendar(identifier: .gregorian)
                let createdDate = calendar.date(
                    from: DateComponents(
                        year: 2025,
                        month: 11,
                        day: 15,
                        hour: 23,
                        minute: 0,
                        second: 53
                    )
                )!
        
        return [
            PaginationCommentModel(
                page: 1,
                isLast: false,
                comments: [
                    .init(commentId: 1, userId: 1, nickName: "김서티",
                          content: "댓글 텍스트댓글 텍스트댓글 텍스트댓글 텍스트댓글텍스트댓글텍스트댓글텍스트댓글텍스트댓글텍스트댓글텍스트댓글텍스트댓글텍스트댓글텍스트댓글텍스트댓텍스트댓글텍스트댓글텍스트댓글텍스트댓글텍스트댓",
                          userMajor: "컴퓨터공학", userJob: "경영사무", state: "취득 완료",
                          likeCount: 1,
                          createdTime:createdDate, lastModifiedTime: createdDate, isLike: false),
                    .init(commentId: 2, userId: 2, nickName: "김서티",
                          content: "댓글 텍스트댓글 텍스트댓글 텍스트댓글 텍스트댓글텍스트댓글텍스트댓글텍스트댓글텍스트댓글텍스트댓글텍스트댓글텍스트댓글텍스트댓글텍스트댓글텍스트댓텍스트댓글텍스트댓글텍스트댓글텍스트댓글텍스트댓",
                          userMajor: "컴퓨터공학", userJob: "경영사무", state: "취득 완료",
                          likeCount: 1,
                          createdTime:createdDate, lastModifiedTime: createdDate, isLike: false),
                    .init(commentId: 3, userId: 3, nickName: "김서티",
                          content: "댓글 텍스트댓글 텍스트댓글 텍스트댓글 텍스트댓글텍스트댓글텍스트댓글텍스트댓글텍스트댓글텍스트댓글텍스트댓글텍스트댓글텍스트댓글텍스트댓글텍스트댓텍스트댓글텍스트댓글텍스트댓글텍스트댓글텍스트댓",
                          userMajor: "컴퓨터공학", userJob: "경영사무", state: "취득 완료",
                          likeCount: 1,
                          createdTime:createdDate, lastModifiedTime: createdDate, isLike: false),])
            ]
    }
}

