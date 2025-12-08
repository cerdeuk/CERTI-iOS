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
    
    // MARK: - Property Wrappers
    
    @State private var heartOn: Bool = false
    
    // MARK: - Properties
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }
    
    let certificationState: CertificationType
    let userName: UserType
    let major: String
    let job: String
    let commentContent: String
    let likeCount: Int
    
    // MARK: - Main Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            userInfomation
                .padding(.top, 8)
            
            Text(commentContent.antiAppleBySangyup)
                .applyCertiFont(.caption_regular_14)
                .foregroundStyle(.grayscale500)
                .frame(width:329)
                .lineLimit(4)
                .padding(.top, 8)
            
            commentInfomation
                .padding(.top, 8)
            
            Rectangle()
                .foregroundStyle(.grayscale100)
                .frame(width: 335, height: 1)
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
            
            Text(userName.isUnknown ? "" : "(\(major), \(job))")
                .applyCertiFont(.caption_semibold_12)
                .foregroundStyle(.grayscale400)
                .padding(.leading, 8)
            
            Spacer()
        }
        .frame(width: 335)
    }
    
    @ViewBuilder
    private var commentInfomation: some View {
        HStack(alignment: .center, spacing: 0) {
            Button {
                // TODO: CommentLikeUseCase
                heartOn.toggle()
            } label: {
                Image(heartOn ? .iconCommentHeartFilled12 : .iconCommentHeartDefault12)
            }
            
            Text("좋아요 \(likeCount)")
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
        .frame(width: 335)
    }
}

#Preview {
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
    }
}

