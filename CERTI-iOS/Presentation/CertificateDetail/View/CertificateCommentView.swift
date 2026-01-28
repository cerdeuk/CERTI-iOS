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
    @Binding var totalCommentCount: Int
    @Binding var certificationId: Int
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            ScrollView(.vertical) {
                HStack(alignment: .center, spacing: 0) {
                    CommentSortButton(isSelectedPopularity: isSelectedPopularity) {
                        isSelectedPopularity.toggle()
                    }
                    .padding(.leading, 20)
                    
                    Spacer()
                    
                    Text("댓글 (\(totalCommentCount))")
                        .applyCertiFont(.caption_regular_14)
                        .foregroundStyle(.grayscale400)
                        .padding(.trailing, 20)
                }
                .padding(.bottom, 12)
                .padding(.top, 36)
                
                LazyVStack(spacing: 0) {
                    ForEach(viewModel.commentList) { comment in
                        CommentComponent(
                            model: comment,
                            certificationState: comment.state == "취득 완료" ? .completed : .expected,
                            userName: comment.nickName == nil ? .unknown : .normal(userName:comment.nickName!),
                            onTapLike: {
                                Task{
                                    // TODO: - 댓글 좋아요 useCase 호출
                                }
                            })
                        .padding(.horizontal, 20)
                    }
                    if !viewModel.isLastPage {
                            ProgressView()
                                .padding(.vertical, 16)
                                .onAppear {
                                    Task {
                                        await viewModel.fetchComment(certificationId: certificationId)
                                    }
                                }
                        }
                }
            }
            .onAppear {
                Task {
                    await viewModel.fetchComment(certificationId: certificationId)
                }
            }
            .onTapGesture {
                hideKeyboard()
            }
            
            CommentTextField(commentText: $viewModel.commentText, onSendTapped: { }, textFieldState: !viewModel.showFailToBeAcquired || !viewModel.showFailAcquired ? .fieldOn : .fieldLock)
                .padding(.vertical, 20)
        }
    }
}
