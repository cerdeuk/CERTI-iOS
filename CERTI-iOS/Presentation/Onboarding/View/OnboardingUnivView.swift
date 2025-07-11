//
//  OnboardingUnivView.swift
//  CERTI-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI

struct OnboardingUnivView: View {
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @EnvironmentObject private var onboardingCoordinator: OnboardingCoordinator
    @ObservedObject var viewModel: OnboardingViewModel
    
    @State private var univListToggle: Bool = false
    @State private var searchBarDisabled: Bool = false
    
    @FocusState private var isSearchFieldFocused: Bool
    
    let univModel = OnboardingUnivModel.dummy()
    let columns = [GridItem(.flexible())]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 0) {
                BackButton {
                    appCoordinator.cancelOnboarding()
                }
                .padding(.bottom, 13)
                
                Image(.onboardingProgressbar1)
                    .padding(.leading, 20)
                    .padding(.bottom, 40)
                
                Text("대학교 이름을 입력해주세요")
                    .applyCertiFont(.sub_bold_20)
                    .foregroundStyle(.grayscale600)
                    .padding(.leading, 20)
                    .padding(.bottom, 38)
                
                SearchBar(text: $viewModel.searchUnivText) {
                    // 돋보기 누르면 대학 리스트 받아오기
                    univListToggle = true
                    isSearchFieldFocused = false
                }
                .disabled(searchBarDisabled)
                .focused($isSearchFieldFocused)
                .onTapGesture {
                    viewModel.searchUnivText = ""
                    viewModel.userUniversity = ""
                    searchBarDisabled = false
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 5)
                
                if univListToggle {
                    ScrollView(.vertical) {
                        LazyVGrid(columns: columns, alignment: .leading) {
                            ForEach(univModel, id: \.id) { univ in
                                VStack(alignment: .leading, spacing: 0) {
                                    Text(univ.university)
                                        .applyCertiFont(.body_regular_16)
                                        .foregroundStyle(.black)
                                        .padding(.horizontal, 20)
                                        .padding(.top, 20)
                                        .padding(.bottom, 17)
                                    
                                    Divider()
                                }
                                .onTapGesture {
                                    viewModel.userUniversity = univ.university
                                    viewModel.searchUnivText = univ.university
                                    searchBarDisabled = true
                                    univListToggle = false
                                }
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                }
                
                Spacer()
            }
            
            Button {
                onboardingCoordinator.push(next: .grade)
            } label: {
                Text("다음")
                    .applyCertiFont(.body_semibold_16)
                    .foregroundStyle(viewModel.searchUnivValidate() ? .white : .grayscale400)
                    .frame(maxWidth: .infinity, minHeight: 56)
            }
            .disabled(!viewModel.searchUnivValidate())
            .background(viewModel.searchUnivValidate() ? .purpleblue : .grayscale100)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal, 20)
            .padding(.bottom, 22)
        }
        .ignoresSafeArea(.keyboard)
    }
}
