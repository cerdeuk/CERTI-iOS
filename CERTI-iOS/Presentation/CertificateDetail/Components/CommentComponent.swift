//
//  CommentComponent.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 12/7/25.
//

import SwiftUI

struct CommentComponent: View {
    enum CertificationType {
            case completed
            case expected

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
    
    enum UserType {
        case unknown
        case normal(userName: String)
        
        var name: String {
            switch self {
            case .unknown: return "(알수없음)"
            case .normal(userName: let userName): return userName
            }
        }
        
        var isUnknown: Bool {
            if case .unknown = self { return true }
            return false
        }
    }
    
    // MARK: - Properties
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }
    
    let model: Comment
    let certificationState: CertificationType
    let userName: UserType
    let onTapLike: () -> Void
    
    // MARK: - Main Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            userInfomation
                .padding(.top, 8)
            
            Text(model.content.antiAppleBySangyup)
                .applyCertiFont(.caption_regular_14)
                .foregroundStyle(.grayscale500)
                .padding(.top, 8)
            
            commentInfomation
                .padding(.top, 8)
            
            Rectangle()
                .foregroundStyle(.grayscale100)
                .frame(height: 1)
                .padding(.top, 8)

        }
    }
}

// MARK: - SubViews

extension CommentComponent {
    @ViewBuilder
    private var userInfomation: some View {
        HStack(alignment: .center, spacing: 0) {
            Text(userName.name)
                .applyCertiFont(.caption_semibold_14)
                .foregroundStyle(userName.isUnknown ? .grayscale300 : .black)
            
            Text(userName.isUnknown ? "" : certificationState.text)
                .applyCertiFont(.caption_semibold_12)
                .foregroundStyle(certificationState.color)
                .padding(.leading, 8)
            
            Text(userName.isUnknown ? "" : "(\(model.userMajor), \(model.userJob))")
                .applyCertiFont(.caption_semibold_12)
                .foregroundStyle(.grayscale400)
                .padding(.leading, 8)
            
            Spacer()
        }
    }
    
    @ViewBuilder
    private var commentInfomation: some View {
        HStack(alignment: .center, spacing: 0) {
            Button {
                // TODO: CommentLikeUseCase
                onTapLike()
            } label: {
                Image(model.isLike ? .iconCommentHeartFilled12 : .iconCommentHeartDefault12)
            }
            
            Text("좋아요 \(model.likeCount)")
                .applyCertiFont(.caption_semibold_12)
                .foregroundStyle(.grayscale400)
                .padding(.leading, 4)
            
            Rectangle()
                .foregroundStyle(.grayscale300)
                .frame(width: 1, height: 12)
                .padding(.leading, 8)
            
            Button {
                // TODO: 신고하기 UseCase
            } label: {
                Text("신고")
                    .applyCertiFont(.caption_semibold_12)
                    .foregroundStyle(.grayscale400)
            }
                .padding(.leading, 8)
            
            Text(dateFormatter.string(from: Date()))
                .applyCertiFont(.caption_semibold_12)
                .foregroundStyle(.grayscale400)
                .padding(.leading, 8)
            
            Spacer()
        }
    }
}
