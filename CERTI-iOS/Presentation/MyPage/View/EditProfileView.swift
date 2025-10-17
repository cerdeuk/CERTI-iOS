//
//  EditProfileView.swift
//  CERTI-iOS
//
//  Created by OneTen on 10/17/25.
//

import SwiftUI

struct EditProfileView: View {
    @ObservedObject var viewModel: MyPageViewModel
    
    @State private var userNickname: String = "김서티"
    @State private var nicknameValidate: nickNameValidateCase? = nil
    
    @State private var userName: String = "김한열"
    @State private var userEmail: String = "certification@gmail.com"
    
    @State private var userBirth: Date? = nil
    @State private var isCalendarVisible: Bool = false
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }
    
    private let maxLength = 7
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            headerView
            
            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: 0) {
                    
                    imageView
                        .padding(.top, 28)
                        .padding(.bottom, 38)
                    
                    nickNameView
                    
                    nicknameValidateCaseView
                        .padding(.horizontal, 20)
                        .padding(.bottom, 24)
                    
                    userNameView
                    userEmailView
                    userBirthView
                    
                    Spacer()
                }
            }
            .scrollIndicators(.hidden)
            
        }
    }
}

extension EditProfileView {
    @ViewBuilder
    private var headerView: some View {
        HStack(alignment: .center, spacing: 0) {
            Button {
                viewModel.myPageViewRoutePop()
            } label: {
                Image(.iconArrowleft36)
            }
            
            Spacer()
            
            Text("개인정보 수정")
                .applyCertiFont(.sub_semibold_20)
                .foregroundStyle(.grayscale600)
                .frame(height: 25)
            
            Spacer()
            
            Button {
                // TODO: - 저장
                viewModel.myPageViewRoutePop()
            } label: {
                Text("저장")
                    .applyCertiFont(.body_semibold_18)
                    .foregroundStyle(.grayscale400)
                    .frame(width: 36, height: 25)
            }
        }
        .padding(.horizontal, 20)
        .frame(height: 68)
    }
    
    @ViewBuilder
    private var imageView: some View {
        HStack(alignment: .center, spacing: 0) {
            Spacer()
            
            ZStack(alignment: .bottomTrailing) {
                ZStack(alignment: .center) {
                    Circle()
                        .frame(width: 100, height: 100)
                        .foregroundStyle(.grayscale100)
                    Image(.iconImage24)
                        .foregroundStyle(.grayscale300)
                }
                
                Button {
                    // TODO: - 이미지 업로드 및 수정
                } label: {
                    Image(.btnProfileEdit)
                }
            }
            
            Spacer()
        }
    }
    
    @ViewBuilder
    private var nickNameView: some View {
        HStack(alignment: .center, spacing: 0) {
            Text("닉네임")
                .applyCertiFont(.body_semibold_16)
                .foregroundStyle(.grayscale600)
            
            Spacer()
            
            Button {
                // TODO: - UI 확인용, 추후 검증 요청 API로 대체
                
                let allCases = nickNameValidateCase.allCases
                
                if let currentCase = nicknameValidate {
                    if let currentIndex = allCases.firstIndex(of: currentCase) {
                        let nextIndex = (currentIndex + 1) % allCases.count
                        nicknameValidate = allCases[nextIndex]
                    }
                } else {
                    nicknameValidate = allCases.first
                }
                
            } label: {
                Text("중복 확인")
                    .applyCertiFont(.caption_regular_12)
                    .foregroundStyle(.grayscale300)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 12)
                    .overlay {
                        Capsule()
                            .stroke(.grayscale200, lineWidth: 1)
                    }
            }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 12)
        
        HStack(alignment: .center, spacing: 0) {
            TextField("", text: $userNickname, prompt: Text(userNickname))
                .maxLength(maxLength, text: $userNickname)
                .applyCertiFont(.body_regular_16)
                .foregroundStyle(.black)
                .frame(height: 24)
                .padding(.vertical, 12)
                .padding(.leading, 12)
            
            Spacer()
            
            if !userNickname.isEmpty {
                Text("\(userNickname.count)/\(maxLength)")
                    .applyCertiFont(.caption_semibold_12)
                    .foregroundStyle(.grayscale500)
                    .padding(.trailing, 12)
            }
        }
        .background(.grayscale0)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay(content: {
            RoundedRectangle(cornerRadius: 8)
                .stroke(nicknameValidate == .none ? .grayscale200 : nicknameValidate == .valid ? .mainblue : .error, lineWidth: 1)
        })
        .padding(.horizontal, 20)
        .padding(.bottom, nicknameValidate == nil ? 24 : 8)
        
    }
    
    @ViewBuilder
    private var nicknameValidateCaseView: some View {
        switch nicknameValidate {
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
    
    @ViewBuilder
    private var userNameView: some View {
        Text("이름")
            .applyCertiFont(.body_semibold_16)
            .foregroundStyle(.grayscale600)
            .padding(.horizontal, 20)
            .padding(.bottom, 12)
        
        TextField("", text: $userName, prompt: Text(userName))
            .applyCertiFont(.body_regular_16)
            .foregroundStyle(.black)
            .frame(height: 24)
            .padding(.vertical, 12)
            .padding(.leading, 12)
            .background(.grayscale0)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(content: {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.grayscale200, lineWidth: 1)
            })
            .padding(.horizontal, 20)
            .padding(.bottom, 24)
    }
    
    @ViewBuilder
    private var userEmailView: some View {
        Text("이메일")
            .applyCertiFont(.body_semibold_16)
            .foregroundStyle(.grayscale600)
            .padding(.horizontal, 20)
            .padding(.bottom, 12)
        
        TextField("", text: $userEmail, prompt: Text(userEmail))
            .applyCertiFont(.body_regular_16)
            .foregroundStyle(.black)
            .frame(height: 24)
            .padding(.vertical, 12)
            .padding(.leading, 12)
            .background(.grayscale0)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(content: {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.grayscale200, lineWidth: 1)
            })
            .padding(.horizontal, 20)
            .padding(.bottom, 24)
    }
    
    @ViewBuilder
    private var userBirthView: some View {
        Text("생년월일")
            .applyCertiFont(.body_semibold_16)
            .foregroundStyle(.grayscale600)
            .padding(.horizontal, 20)
            .padding(.bottom, 12)
        
        VStack(alignment: .leading, spacing: 0) {
            Button {
                withAnimation {
                    isCalendarVisible.toggle()
                }
            } label: {
                HStack(alignment: .center, spacing: 0) {
                    if let userBirth {
                        Text(dateFormatter.string(from: userBirth))
                            .applyCertiFont(.caption_regular_14)
                            .foregroundStyle(.black)
                    } else {
                        Text("생년월일을 선택해주세요.")
                            .applyCertiFont(.caption_semibold_14)
                            .foregroundStyle(.grayscale300)
                    }
                    
                    Spacer()
                    
                    Image(.iconArrowdown24)
                        .foregroundStyle(.grayscale400)
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 12)
            }
            .background(.grayscale0)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.grayscale200, lineWidth: 1)
            )
            .padding(.horizontal, 20)
            
            if isCalendarVisible {
                let binding = Binding<Date>(
                    get: { self.userBirth ?? Date() },
                    set: {
                        self.userBirth = $0
                        withAnimation {
                            self.isCalendarVisible = false
                        }
                    }
                )
                
                DatePicker("", selection: binding, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .environment(\.locale, Locale(identifier: "ko"))
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.grayscale100, lineWidth: 1)
                    }
                    .padding(.top, 8)
                    .padding(.horizontal, 8)
            }
            
        }
        .padding(.bottom, 24)
    }
    
}
