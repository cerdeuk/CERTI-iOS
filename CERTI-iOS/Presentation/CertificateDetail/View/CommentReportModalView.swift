//
//  CommentReportModalView.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 2/11/26.
//

import SwiftUI

struct CommentReportModalView: View {
    @ObservedObject var viewModel: CertificateDetailViewModel

    @Binding var stateCommentReportModal: Bool
    @Binding var commentId: Int

    private let maxLength: Int = 100

    
    // MARK: - Main Body

    var body: some View {
            VStack(spacing: 0) {
                header
                content
            }
            .frame(width: 335, height: 395)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal, 20)
    }

    
    // MARK: - SubView

    private var header: some View {
        HStack(alignment: .center, spacing: 0) {
            Text("신고하기")
                .applyCertiFont(.caption_semibold_14)
                .foregroundStyle(.black)

            Spacer()

            Button {
                viewModel.dismissCommentReportModal()
            } label: {
                Image(.iconModalclose24)
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 20)
        .padding(.top, 18)
    }

    private var content: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("신고 내용")
                .applyCertiFont(.caption_semibold_12)
                .foregroundStyle(.grayscale400)
                .frame(height: 18)
                .padding(.bottom, 4)

            VStack(alignment: .leading, spacing: 0) {
                ZStack(alignment: .topLeading) {
                    if viewModel.reportContent.isEmpty {
                        Text("내용을 입력해주세요.")
                            .applyCertiFont(.caption_regular_12)
                            .foregroundStyle(.grayscale300)
                            .padding(.top, 12)
                            .padding(.leading, 19.5)
                    }

                    TextEditor(text: $viewModel.reportContent)
                        .applyCertiFont(.caption_regular_12)
                        .foregroundStyle(.grayscale600)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 16)
                        .scrollContentBackground(.hidden)
                        .background(Color.clear)
                        .blackCursor()
                        .onChange(of: viewModel.reportContent) {
                            viewModel.updateReportContent($0)
                        }
                }
                .frame(width: 295, height: 114)
                .background(.grayscale0)
                .clipShape(RoundedRectangle(cornerRadius: 12))

                HStack {
                    Spacer()
                    Text("\(viewModel.reportContentCountWithoutWhitespace)/\(maxLength)")                        .applyCertiFont(.caption_regular_10)
                        .foregroundStyle(.grayscale300)
                        .padding(.top, 4)
                }
            }

            Button {
                viewModel.shouldBlockUser.toggle()
            } label: {
                HStack(alignment: .center, spacing: 0) {
                    Image(viewModel.shouldBlockUser ? .iconSmallCheckboxCheck16 : .iconSmallCheckbox16)
                    
                    Text("해당 유저 차단하기")
                        .applyCertiFont(.caption_semibold_12)
                        .foregroundStyle(.grayscale600)
                        .padding(.leading, 8)
                }
            }

            VStack(alignment: .leading, spacing: 8) {
                bullet("신고된 콘텐츠는 관리자가 검토하며, 필요 시 댓글 삭제,\n계정 제한 등의 조치가 이루어집니다.")
                bullet("차단 기능을 사용하면, 관리자의 확인을 거쳐 해당 사용자의 댓글이 사용자에게 노출되지 않도록 처리됩니다.")
            }
            .padding(.top, 12)
            .padding(.leading, 6)

            HStack {
                Spacer()
                Button {
                    Task {
                        let trimmed = viewModel.reportContent
                            .trimmingCharacters(in: .whitespacesAndNewlines)
                        let contentToSend: String? = trimmed.isEmpty ? nil : trimmed
                        
                        await viewModel.reportComment(commentId: commentId, content: contentToSend, shouldBlockUser: viewModel.shouldBlockUser)
                        viewModel.dismissCommentReportModal()
                    }
                } label: {
                    Text("제출")
                        .applyCertiFont(.caption_semibold_12)
                        .foregroundStyle(.mainblue)
                        .frame(width: 66, height: 30)
                        .background(
                            RoundedRectangle(cornerRadius: 24, style: .continuous)
                                .stroke(.mainblue, lineWidth: 1)
                        )
                }
            }
            .padding(.top, 20)
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
        .padding(.bottom, 20)
    }

    private func bullet(_ text: String) -> some View {
        HStack(alignment: .top, spacing: 5) {
            Text("•")
                .applyCertiFont(.caption_semibold_14)
                .foregroundStyle(.grayscale400)

            Text(text.antiAppleBySangyup)
                .applyCertiFont(.caption_regular_12)
                .foregroundStyle(.grayscale400)
                .fixedSize(horizontal: false, vertical: true)
                .frame(width: 260)
        }
    }
}
