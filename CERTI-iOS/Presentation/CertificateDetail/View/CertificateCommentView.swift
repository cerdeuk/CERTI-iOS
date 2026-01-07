//
//  CertificateCommentView.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 1/7/26.
//

import SwiftUI

struct CertificateCommentView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            CommentComponent(certificationState: .completed,
                             userName: .normal(userName: "김서티"),
                             major: "컴퓨터공학",
                             job: "경영사무",
                             commentContent: "댓글 텍스트댓글 텍스트댓글 텍스트댓글 텍스트댓글텍스트댓글텍스트댓글텍스트댓글텍스트댓글텍스트댓글텍스트댓글텍스트댓글텍스트댓글텍스트댓글텍스트댓글텍스트댓글텍스트댓글텍스트댓텍스트댓글텍스트댓글텍스트댓글텍스트댓글텍스트댓",
                             likeCount: 110)
            
            CommentComponent(certificationState: .expected,
                             userName: .normal(userName: "김서티"),
                             major: "컴퓨터공학",
                             job: "경영사무",
                             commentContent: "댓글 텍스트댓글 텍스트댓글 텍스트댓글 텍스트댓글텍스트댓글텍스트댓글텍스트댓글텍스트댓글텍스트댓글텍스트댓글텍스트댓글텍스트댓글텍스트댓글텍스트댓텍스트댓글텍스트댓글텍스트댓글텍스트댓글텍스트댓",
                             likeCount: 110)
            
            CommentComponent(certificationState: .expected,
                             userName: .unknown,
                             major: "컴퓨터공학",
                             job: "경영사무",
                             commentContent: "댓글 텍스트댓글 텍스트댓글 텍스트댓글 텍스트댓글텍스트댓글텍스트댓글텍스트댓글텍스트댓글텍스트댓글텍스트댓글텍스트댓글텍스트댓글텍스트댓글텍스트댓텍스트댓글텍스트댓글텍스트댓글텍스트댓글텍스트댓",
                             likeCount: 110)
        }    }
}

#Preview {
    CertificateCommentView()
}
