//
//  OnboardingNickNameView.swift
//  CERTI-iOS
//
//  Created by OneTen on 10/17/25.
//

import SwiftUI

enum nickNameValidateCase: CaseIterable {
    case valid
    case duplicate
    case abuse
    case empty
}

struct OnboardingNickNameView: View {
    @ObservedObject var viewModel: OnboardingViewModel

    private let maxLength = 7
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            BackButton {
                viewModel.onboardingViewRoutePop()
            }
            .padding(.bottom, 13)
            
            Image(.onboardingProgressbar6)
                .padding(.leading, 20)
                .padding(.bottom, 40)
            
            Text("따요에서 사용할 닉네임을\n입력해 주세요.")
                .applyCertiFont(.sub_semibold_20)
                .foregroundStyle(.grayscale600)
                .frame(minHeight: 52)
                .padding(.leading, 20)
                .padding(.bottom, 40)
            
            Text("닉네임")
                .applyCertiFont(.caption_regular_12)
                .foregroundStyle(.grayscale600)
                .frame(height: 18)
                .padding(.leading, 20)
                .padding(.bottom, 20)
            
            nicknameTextField
                .padding(.horizontal, 20)
                .padding(.bottom, viewModel.nickNameValid == nil ? 48 : 12)
            
            nicknameValidateCaseView
                .padding(.leading, 20)
                .padding(.bottom, 16)
            
            Button {
                Task {
                    await viewModel.checkNickNameValidate()
                }
            } label: {
                VStack(alignment: .leading, spacing: 0) {
                    Text("닉네임 중복 확인")
                        .applyCertiFont(.caption_regular_14)
                        .foregroundStyle(.grayscale500)
                        .frame(height: 20)
                    
                    Color.grayscale500.frame(width: 92, height: 1)
                }
            }
            .padding(.leading, 20)
            
            
            Spacer()
            
            Button {
                viewModel.navigateToInfo()
            } label: {
                Text("다음")
                    .applyCertiFont(.body_semibold_16)
                    .foregroundColor(viewModel.nickNameValid != .valid ? .grayscale400 : .white)
                    .frame(maxWidth: .infinity, minHeight: 56)
                    .background(viewModel.nickNameValid != .valid ? .grayscale100 : .purpleblue)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .disabled(viewModel.nickNameValid != .valid)
            .padding(.horizontal, 20)
            .padding(.bottom, 22)
        }
    }
}

extension OnboardingNickNameView {
    @ViewBuilder
    private var nicknameTextField: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                TextField("", text: $viewModel.nickname, prompt: Text("닉네임 입력").foregroundColor(.grayscale400))
                    .maxLength(maxLength, text: $viewModel.nickname)
                    .applyCertiFont(.body_regular_16)
                    .foregroundStyle(.black)
                    .frame(height: 24)
                
                Spacer()
                
                if !viewModel.nickname.isEmpty {
                    Button {
                        viewModel.nickname = ""
                    } label: {
                        Image(.iconNicknameclose24)
                    }
                    .padding(.trailing, 10)
                }
                
                Text("\(viewModel.nickname.count)/\(maxLength)")
                    .applyCertiFont(.caption_semibold_14)
                    .foregroundStyle(.grayscale300)
                    .frame(height: 20)
            }
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(viewModel.nickNameValid == .none ? .grayscale300 : viewModel.nickNameValid == .valid ? .mainblue : .error)
                .padding(.top, 13)
        }
        .frame(height: 34)
    }
    
    @ViewBuilder
    private var nicknameValidateCaseView: some View {
        switch viewModel.nickNameValid {
        case .valid:
            Text("사용 가능한 닉네임입니다.")
                .applyCertiFont(.caption_regular_14)
                .foregroundStyle(.mainblue)
                .frame(height: 20)
        case .duplicate:
            Text("이미 사용중인 닉네임입니다.")
                .applyCertiFont(.caption_regular_14)
                .foregroundStyle(.error)
                .frame(height: 20)
        case .abuse:
            Text("욕설과 비속어 등은 사용할 수 없습니다.")
                .applyCertiFont(.caption_regular_14)
                .foregroundStyle(.error)
                .frame(height: 20)
        case .empty:
            Text("닉네임을 입력해 주세요.")
                .applyCertiFont(.caption_regular_14)
                .foregroundStyle(.error)
                .frame(height: 20)
        default:
            EmptyView()
        }
    }
}
