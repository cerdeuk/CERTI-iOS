//
//  CertificateCommentView.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 1/7/26.
//

import SwiftUI

struct CertificateCommentView: View {
    @Binding var isSelectedPopularity: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            HStack {
                CommentSortButton(isSelectedPopularity: isSelectedPopularity){
                    isSelectedPopularity.toggle()
                    //                Task {
                    //                    await viewModel.getCategoryList()
                    //                }
                }
                .padding(.leading, 20)
                
                Spacer()
                
                Text("댓글 (00)")
                    .applyCertiFont(.caption_regular_14)
                    .foregroundStyle(.grayscale400)
                    .padding(.trailing, 20)
            }
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
        }
        .frame(width: .infinity)
    }
}

#Preview {
    struct PreviewWrapper: View {
        
        @State var isSelectedPopularity = true
        var body: some View {
            CertificateCommentView(isSelectedPopularity: $isSelectedPopularity)
        }
    }
    return PreviewWrapper()
    
}
