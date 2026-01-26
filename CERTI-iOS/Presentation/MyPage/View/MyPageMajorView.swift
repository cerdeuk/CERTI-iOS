//
//  MyPageMajorView.swift
//  CERTI-iOS
//
//  Created by OneTen on 10/30/25.
//

import SwiftUI

struct MyPageMajorView: View {
    @ObservedObject var viewModel: MyPageViewModel
    
    @State private var searchMajorText = ""
    @State private var userMajor = ""
    
    @State private var majorListToggle: Bool = false
    @State private var searchBarDisabled: Bool = false
    
    @FocusState private var isSearchFieldFocused: Bool
    
    let columns = [GridItem(.flexible())]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            headerView
            
            Text("학과를 선택해주세요")
                .applyCertiFont(.sub_bold_20)
                .foregroundStyle(.grayscale600)
                .frame(height: 26)
                .padding(.horizontal, 20)
                .padding(.top, 24)
                .padding(.bottom, 38)
            
            SearchBar(text: $searchMajorText) {
                // 돋보기 누르면 대학 리스트 받아오기
                majorListToggle = true
                isSearchFieldFocused = false
                
                Task {
                    await viewModel.getMajorList(keyword: searchMajorText)
                }
            }
            .disabled(searchBarDisabled)
            .focused($isSearchFieldFocused)
            .onTapGesture {
                searchMajorText = ""
                userMajor = ""
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
                            .onTapGesture {
                                userMajor = major
                                searchMajorText = major
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
        
        
        Spacer()
    }
    
}

extension MyPageMajorView {
    @ViewBuilder
    private var headerView: some View {
        HStack(alignment: .center, spacing: 0) {
            Button {
                viewModel.myPageViewRoutePop()
            } label: {
                Image(.iconArrowleft36)
            }
            
            Spacer()
            
            Button {
                // TODO: - 저장
                viewModel.myPageViewRoutePop()
            } label: {
                Text("저장")
                    .applyCertiFont(.body_semibold_18)
                    .foregroundStyle(!searchMajorText.isEmpty && !userMajor.isEmpty ? .mainblue : .grayscale400)
                    .frame(width: 36, height: 25)
            }
        }
        .padding(.horizontal, 20)
        .frame(height: 68)
    }
}
