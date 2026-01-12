//
//  CommentTextField.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 1/12/26.
//

import SwiftUI

struct CommentTextField: View {
    enum TextFieldState {
        case fieldOn
        case fieldLock
        
        var placeholder: String {
            switch self {
            case .fieldOn: return "댓글을 입력하세요."
            case .fieldLock: return "자격증 취득예정/완료 후 댓글 작성이 가능합니다."
            }
        }
        
        var isLocked: Bool {
            self == .fieldLock
        }
    }
    
    // MARK: - Property Wrapper
    
    @Binding var commentText: String
    
    // MARK: - Properties
    
    var onSendTapped: () -> Void
    
    let textFieldState : TextFieldState
    
    // MARK: - Main Body
    
    var body: some View {
        HStack {
            if textFieldState.isLocked {
                Image(.iconLocked20)
                    .padding(.leading, 12)
            }
            
            TextField("", text: $commentText, prompt: Text(textFieldState.placeholder).foregroundColor(.grayscale300))
                .applyCertiFont(.caption_regular_14)
                .foregroundStyle(.black)
                .padding(.leading, textFieldState.isLocked ? 0 : 12)
                .disabled(textFieldState.isLocked)
            
            Spacer()
            
            if !textFieldState.isLocked {
                Button {
                    onSendTapped()
                } label: {
                    Image(commentText.isEmpty ? .iconSend24Disable : .iconSend24Able)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(
                            commentText.isEmpty ? .grayscale300 : .grayscale600
                        )
                        .padding(.trailing, 8)
                }
                .disabled(commentText.isEmpty)
            }
        }
        .frame(height: 40)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(.grayscale100))
        .padding(.horizontal, 20)
        
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State var commentText: String = ""
        
        var body: some View {
            CommentTextField(commentText: $commentText, onSendTapped: {}, textFieldState: .fieldOn)
            CommentTextField(commentText: $commentText, onSendTapped: {}, textFieldState: .fieldLock)
        }
    }
    
    return PreviewWrapper()
}
