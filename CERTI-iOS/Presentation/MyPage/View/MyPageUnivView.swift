//
//  MyPageUnivView.swift
//  CERTI-iOS
//
//  Created by OneTen on 10/30/25.
//

import SwiftUI

struct MyPageUnivView: View {
    @ObservedObject var viewModel: MyPageViewModel
    
    @State private var searchUnivText = ""
    @State private var userUniversity = ""
    
    @State private var univListToggle: Bool = false
    @State private var searchBarDisabled: Bool = false
    
    @FocusState private var isSearchFieldFocused: Bool
    
    let columns = [GridItem(.flexible())]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            headerView
            
            Text("대학교 이름을 입력해주세요")
                .applyCertiFont(.sub_bold_20)
                .foregroundStyle(.grayscale600)
                .frame(height: 26)
                .padding(.horizontal, 20)
                .padding(.top, 24)
                .padding(.bottom, 38)
            
            SearchBar(text: $searchUnivText) {
                univListToggle = true
                isSearchFieldFocused = false
                
                Task {
                    await viewModel.getUnivList(keyword: searchUnivText)
                }
            }
            .disabled(searchBarDisabled)
            .focused($isSearchFieldFocused)
            .onTapGesture {
                searchUnivText = ""
                userUniversity = ""
                searchBarDisabled = false
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 5)
            
            if univListToggle {
                ScrollView(.vertical) {
                    LazyVGrid(columns: columns, alignment: .leading) {
                        ForEach(viewModel.universityList, id: \.self) { univ in
                            VStack(alignment: .leading, spacing: 0) {
                                Text(univ)
                                    .applyCertiFont(.body_regular_16)
                                    .foregroundStyle(.black)
                                    .padding(.horizontal, 20)
                                    .padding(.top, 20)
                                    .padding(.bottom, 17)
                                
                                Divider()
                            }
                            .onTapGesture {
                                userUniversity = univ
                                searchUnivText = univ
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
        
        
        Spacer()
    }
    
}

extension MyPageUnivView {
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
                Task {
                    await viewModel.editUniv(univ: userUniversity)
                }
                viewModel.myPageViewRoutePop()
            } label: {
                Text("저장")
                    .applyCertiFont(.body_semibold_18)
                    .foregroundStyle(!searchUnivText.isEmpty && !userUniversity.isEmpty ? .mainblue : .grayscale400)
                    .frame(width: 36, height: 25)
            }
        }
        .padding(.horizontal, 20)
        .frame(height: 68)
    }
}
