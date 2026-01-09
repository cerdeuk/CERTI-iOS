//
//  CertificateCommentView.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 1/7/26.
//

import SwiftUI

struct CertificateCommentView: View {
    @ObservedObject var viewModel: CertificateDetailViewModel

    @Binding var isSelectedPopularity: Bool
    @Binding var CommentCount: Int
    
    var body: some View {
        ScrollView(.vertical) {
                HStack(alignment: .center, spacing: 0) {
                    CommentSortButton(isSelectedPopularity: isSelectedPopularity){
                        isSelectedPopularity.toggle()
                        // TODO: - 댓글조회 API
                    }
                    .padding(.leading, 20)
                    
                    Spacer()
                    
                    Text("댓글 (\(CommentCount))")
                        .applyCertiFont(.caption_regular_14)
                        .foregroundStyle(.grayscale400)
                        .padding(.trailing, 20)
                }
                .padding(.bottom, 12)
                .padding(.top, 36)
                
            ForEach(viewModel.paginationComments) { page in
                ForEach(page.comments) { comment in
                    CommentComponent(
                        certificationState: comment.state == "취득 완료" ? .completed : .expected,
                        userName: .normal(userName: comment.nickName),
                        major: comment.userMajor,
                        job: comment.userJob,
                        commentContent: comment.content,
                        likeCount: comment.likeCount
                    )
                    .padding(.horizontal, 20)
                }
            }
        }
    }
}
