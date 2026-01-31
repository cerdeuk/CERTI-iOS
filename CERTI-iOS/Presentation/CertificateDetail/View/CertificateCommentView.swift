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
                        Task {
                            await viewModel.refreshComments(certificationId: certificationId)
                        }
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
                    if viewModel.comments.isEmpty {
                        VStack(alignment: .center, spacing: 0) {
                            Image(.imageEmpty)
                                .padding(.top, 134)
                            
                            Text("아직 댓글이 없습니다.\n가장 먼저 댓글을 작성해보세요.")
                                .multilineTextAlignment(.center)
                                .applyCertiFont(.caption_regular_14)
                                .foregroundStyle(.grayscale400)
                                .frame(height: 40)
                                .padding(.top, 20)
                        }
                        .frame(maxWidth: .infinity)
                    } else {
                        ForEach(viewModel.comments) { comment in
                            CommentComponent(
                                model: comment,
                                certificationState: comment.state == "취득 완료" ? .completed : .expected,
                                userName: comment.nickName == nil ? .unknown : .normal(userName:comment.nickName!),
                                onTapLike: {
                                    Task{
                                        await viewModel.toggleLike(commentId: comment.commentId)
                                    }
                                }, onTapDelete: {
                                    Task {
                                        await viewModel.deleteComment(commentId: comment.commentId)
                                    }
                                })
                            .padding(.horizontal, 20)
                        }
                        if !viewModel.isLastPage {
                            ProgressView()
                                .padding(.vertical, 16)
                                .task {
                                    await viewModel.fetchComment(certificationId: certificationId)
                                }
                        }
                    }
                }
            }
            .task {
                await viewModel.fetchComment(certificationId: certificationId)
            }
            .onTapGesture {
                hideKeyboard()
            }
            .onDisappear {
                viewModel.resetComments()
            }
            
            CommentTextField(commentText: $viewModel.commentText, onSendTapped: {
                Task {
                    await viewModel.addComment(content: viewModel.commentText, certificationId: certificationId)
                }
            }, textFieldState: !viewModel.showFailToBeAcquired || !viewModel.showFailAcquired ? .fieldOn : .fieldLock)
            .padding(.vertical, 20)
        }
    }
}
