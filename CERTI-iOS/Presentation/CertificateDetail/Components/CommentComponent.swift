//
//  CommentComponent.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 12/7/25.
//

import SwiftUI

struct CommentComponent: View {
    enum CertificationType {
            case completed(date: String, score: String?)
            case expected(location: String, time: String)

            var text: String {
                switch self {
                case .completed: return "취득 완료"
                case .expected: return "취득 예정"
                }
            }

            var color: Color {
                switch self {
                case .completed: return .purpleblue
                case .expected: return .grayscale300
                }
            }
        }
    
    enum haertState {
        case heartOn
        case heartCancle
    }
    
    // MARK: - Properties
    
    let userName: String
    let certificationState: CertificationType
    let userInfo: String
    let commentContent: String
    let heartCount: String
    let likeCount: Int
    
    // MARK: - Main Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            userInfomation
                .padding(.top, 8)
            
            Text(commentContent)
                .applyCertiFont(.caption_regular_14)
                .foregroundStyle(.grayscale500)
                .frame(height: 80)
                .padding(.top, 8)
        }
    }
}

// MARK: - SubViews

extension CommentComponent {
    @ViewBuilder
    private var userInfomation: some View {
        HStack(alignment: .center, spacing: 0) {
            Text(userName)
                .applyCertiFont(.caption_semibold_14)
                .foregroundStyle(.black)
            
            Text(certificationState.text)
                .applyCertiFont(.caption_semibold_12)
                .foregroundStyle(certificationState.color)
                .padding(.leading, 8)
            
            Text(userInfo)
                .applyCertiFont(.caption_semibold_12)
                .foregroundStyle(.grayscale400)
                .padding(.leading, 8)
        }
    }
    
    @ViewBuilder
    private var commentInfomation: some View {
        HStack(alignment: .center, spacing: 0) {
            Button {
                // TODO: CommentLikeUseCase
            } label: {
                Image(.iconCommentHeartDefault12)
            }
            
            Text("좋아요")
                .applyCertiFont(.caption_semibold_12)
                .foregroundStyle(.grayscale400)
            
            Text("\(likeCount)")
                .applyCertiFont(.caption_semibold_12)
                .foregroundStyle(.grayscale400)
            
            Rectangle()
            
            Text("신고")
                .applyCertiFont(.caption_semibold_12)
                .foregroundStyle(.grayscale400)
            
            Text("2025.08.01")
                .applyCertiFont(.caption_semibold_12)
                .foregroundStyle(.grayscale400)
        }
    }
}

#Preview {
    CommentComponent()
}
