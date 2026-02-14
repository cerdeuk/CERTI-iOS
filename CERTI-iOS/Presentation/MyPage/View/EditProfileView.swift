//
//  EditProfileView.swift
//  CERTI-iOS
//
//  Created by OneTen on 10/17/25.
//

import SwiftUI

import Kingfisher
import PhotosUI

struct EditProfileView: View {
    @ObservedObject var viewModel: MyPageViewModel
    
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
            
            MyPageHeader(style: .save, title: "개인정보 수정", isActionEnabled: viewModel.isProfileSaveEnabled) {
                if viewModel.isProfileModified {
                    Task {
                        await viewModel.editProfileInfo()
                        viewModel.nickNameValid = nil
                        viewModel.myPageViewRoutePop()
                    }
                }
            } backButtonAction: {
                viewModel.nickNameValid = nil
                viewModel.myPageViewRoutePop()
            }
            
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
        .task {
            await viewModel.fetchEditProfileInfo()
        }
    }
}

extension EditProfileView {
    @ViewBuilder
    private var imageView: some View {
        HStack(alignment: .center, spacing: 0) {
            Spacer()
            
            ZStack(alignment: .bottomTrailing) {
                
                if let selected = viewModel.selectedUIImage {
                    Image(uiImage: selected)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(.circle)
                        .clipped()
                } else if viewModel.profileImageURL.isEmpty {
                    ZStack(alignment: .center) {
                        Circle()
                            .frame(width: 100, height: 100)
                            .foregroundStyle(.grayscale100)
                        Image(.iconImage24)
                            .foregroundStyle(.grayscale300)
                    }
                } else {
                    KFImage(URL(string: viewModel.profileImageURL))
                        .resizable()
                        .placeholder {
                            Color.grayscale100
                        }
                        .retry(maxCount: 3, interval: .seconds(5))
                        .onFailure { error in
                            print("failure: \(error.localizedDescription)")
                        }
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(.circle)
                        .clipped()
                }
                
                PhotosPicker(
                    selection: $viewModel.selectedPhotosPickerItem,
                    matching: .images,
                    photoLibrary: .shared()
                ) {
                    Image(.btnProfileEdit)
                }
            }
            .onChange(of: viewModel.selectedPhotosPickerItem) { _ in
                Task { await viewModel.loadSelectedImage() }
            }
            .onDisappear {
                viewModel.clearSelectedImage()
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
                Task {
                    await viewModel.checkNickNameValidate()
                }
            } label: {
                Text("중복 확인")
                    .applyCertiFont(.caption_regular_12)
                    .foregroundStyle(viewModel.nickNameValid == .valid ? .grayscale300 : .grayscale600)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 12)
                    .overlay {
                        Capsule()
                            .stroke(viewModel.nickNameValid == .valid ? .grayscale200 : .grayscale300, lineWidth: 1)
                    }
            }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 12)
        
        HStack(alignment: .center, spacing: 0) {
            TextField("", text: $viewModel.userNickName, prompt: Text(viewModel.userNickName))
                .maxLength(maxLength, text: $viewModel.userNickName)
                .applyCertiFont(.body_regular_16)
                .foregroundStyle(.black)
                .frame(height: 24)
                .padding(.vertical, 12)
                .padding(.leading, 12)
            
            Spacer()
            
            if !viewModel.userNickName.isEmpty {
                Text("\(viewModel.userNickName.count)/\(maxLength)")
                    .applyCertiFont(.caption_semibold_12)
                    .foregroundStyle(.grayscale500)
                    .padding(.trailing, 12)
            }
        }
        .background(.grayscale0)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay(content: {
            RoundedRectangle(cornerRadius: 8)
                .stroke(viewModel.nickNameValid == .none ? .grayscale200 : viewModel.nickNameValid == .valid ? .mainblue : .error, lineWidth: 1)
        })
        .padding(.horizontal, 20)
        .padding(.bottom, viewModel.nickNameValid == nil ? 24 : 8)
        
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
    
    @ViewBuilder
    private var userNameView: some View {
        Text("이름")
            .applyCertiFont(.body_semibold_16)
            .foregroundStyle(.grayscale600)
            .padding(.horizontal, 20)
            .padding(.bottom, 12)
        
        TextField("", text: $viewModel.userName, prompt: Text(viewModel.userName))
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
        
        TextField("", text: $viewModel.userEmail, prompt: Text(viewModel.userEmail))
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
                    if viewModel.userBirth != nil {
                        Text(dateFormatter.string(from: viewModel.userBirth!))
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
                    get: { self.viewModel.userBirth ?? Date() },
                    set: {
                        self.viewModel.userBirth = $0
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
