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
    let likeCount: Int
    let createdTime: String
    let lastModifiedTime: String
    var isLike: Bool
    
    var id: Int { commentId }
}

struct PaginationCommentModel: Identifiable {
    let totalPages: Int
    let totalElements: Int
    let isLast: Bool
    let content: [Comment]
    
    var id: Int { totalPages }
}

extension PaginationCommentModel {
    static func dummy() -> [PaginationCommentModel] {
        return [
                PaginationCommentModel(
                totalPages: 4,
                totalElements: 24,
                isLast: false,
                content: (1...6).map { id in
                    Comment(
                        commentId: id,
                        userId: id,
                        nickName: "서티_페이지1",
                        content: "페이지 1 댓글 \(id)",
                        userMajor: "컴퓨터공학",
                        userJob: "경영사무",
                        state: "취득 완료",
                        likeCount: id,
                        createdTime: "2026-01-11",
                        lastModifiedTime: "2026-01-11",
                        isLike: false
                    )
                }
            ),
                PaginationCommentModel(
                totalPages: 4,
                totalElements: 24,
                isLast: false,
                content: (7...12).map { id in
                    Comment(
                        commentId: id,
                        userId: id,
                        nickName: "서티_페이지2",
                        content: "페이지 2 댓글 \(id)",
                        userMajor: "전자공학",
                        userJob: "개발자",
                        state: "취득 예정",
                        likeCount: id,
                        createdTime: "2026-01-11",
                        lastModifiedTime: "2026-01-11",
                        isLike: id % 2 == 0
                    )
                }
            ),
                PaginationCommentModel(
                totalPages: 4,
                totalElements: 24,
                isLast: false,
                content: (13...18).map { id in
                    Comment(
                        commentId: id,
                        userId: id,
                        nickName: id % 2 == 0 ? nil : "서티_페이지3",
                        content: "페이지 3 댓글 \(id)",
                        userMajor: "산업공학",
                        userJob: "기획자",
                        state: "취득 완료",
                        likeCount: id,
                        createdTime: "2026-01-11",
                        lastModifiedTime: "2026-01-11",
                        isLike: false
                    )
                }
            ),
            PaginationCommentModel(
                totalPages: 4,
                totalElements: 24,
                isLast: true,
                content: (19...24).map { id in
                    Comment(
                        commentId: id,
                        userId: id,
                        nickName: "서티_페이지4",
                        content: "페이지 4 댓글 \(id)",
                        userMajor: "컴퓨터공학",
                        userJob: "디자이너",
                        state: "취득 예정",
                        likeCount: id,
                        createdTime: "2026-01-11",
                        lastModifiedTime: "2026-01-11",
                        isLike: true
                    )
                }
            )
        ]
    }
}

