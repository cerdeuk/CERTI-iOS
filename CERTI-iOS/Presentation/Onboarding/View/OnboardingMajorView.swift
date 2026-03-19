//
//  OnboardingMajorView.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/12/25.
//

import SwiftUI

struct OnboardingMajorView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    @State private var majorListToggle: Bool = false
    @State private var searchBarDisabled: Bool = false
    
    @FocusState private var isSearchFieldFocused: Bool
    
    let columns = [GridItem(.flexible())]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 0) {
                BackButton {
                    viewModel.onboardingViewRoutePop()
                }
                .padding(.bottom, 13)
                
                Image(.onboardingProgressbar4)
                    .padding(.leading, 20)
                    .padding(.bottom, 40)
                
                Text("학과를 선택해주세요")
                    .applyCertiFont(.sub_bold_20)
                    .foregroundStyle(.grayscale600)
                    .padding(.leading, 20)
                    .padding(.bottom, 38)
                
                SearchBar(text: $viewModel.searchMajorText) {
                    // 돋보기 누르면 대학 리스트 받아오기
                    majorListToggle = true
                    isSearchFieldFocused = false
                    
                    Task {
                        await viewModel.getMajorList(keyword: viewModel.searchMajorText)
                    }
                }
                .disabled(searchBarDisabled)
                .focused($isSearchFieldFocused)
                .onTapGesture {
                    viewModel.searchMajorText = ""
                    viewModel.userMajor = ""
                    searchBarDisabled = false
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 5)
                
                if majorListToggle {
                    ScrollView(.vertical) {
                        LazyVGrid(columns: columns, alignment: .leading) {
                            ForEach(viewModel.majorList, id: \.self) { major in
                                VStack(alignment: .leading, spacing: 0) {
                                    Text(major)
                                        .applyCertiFont(.body_regular_16)
                                        .foregroundStyle(.black)
                                        .padding(.horizontal, 20)
                                        .padding(.top, 20)
                                        .padding(.bottom, 17)
                                    
                                    Divider()
                                }
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    viewModel.userMajor = major
                                    viewModel.searchMajorText = major
                                    searchBarDisabled = true
                                    majorListToggle = false
                                }
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                }
                
                Spacer()
            }
            
            ZStack(alignment: .center) {
                Color.white
                    .frame(height: 88)
                    .ignoresSafeArea(edges: .bottom)
                
                Button {
                    viewModel.navigateToJobCategory()
                } label: {
                    Text("다음")
                        .applyCertiFont(.body_semibold_16)
                        .foregroundStyle(viewModel.searchMajorValidate() ? .white : .grayscale400)
                        .frame(maxWidth: .infinity, minHeight: 56)
                }
                .disabled(!viewModel.searchMajorValidate())
                .background(viewModel.searchMajorValidate() ? .purpleblue : .grayscale100)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal, 20)
            }
        }
        .ignoresSafeArea(.keyboard)
    }
}
