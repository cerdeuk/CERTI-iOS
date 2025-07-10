//
//  CategorySearchView.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/6/25.
//

import SwiftUI

enum SearchResultType {
    case empty
    case noResult
    case result
}

struct CategorySearchView: View {
    @EnvironmentObject var categoryCoordinator: CategoryCoordinator
    @ObservedObject var viewModel: CategoryViewModel
    
    var body: some View {
        ZStack {
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    hideKeyboard()
                }
            
            VStack(spacing: 0) {
                BackButton {
                    categoryCoordinator.pop()
                }
                .padding(.bottom, 12)
                
                SearchBar(text: $viewModel.inputText) {
                    if viewModel.inputText.isEmpty {
                        viewModel.searchResult = .empty
                    } else if viewModel.inputText.trimmingCharacters(in: .whitespacesAndNewlines) == "뿡" {
                        viewModel.searchResult = .noResult
                    } else {
                        viewModel.searchResult = .result
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                
                if let result = viewModel.searchResult {
                    switch result {
                    case .empty:
                        EmptyView()
                    case .noResult:
                        CategoryEmptySearchResultView
                    case .result:
                        CategorySearchResultView
                    }
                }
                
                Spacer()
                
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private var CategorySearchResultView: some View {
        VStack(spacing: 0) {
            ScrollView {
                HStack(spacing: 0) {
                    Text("총 ")
                        .foregroundStyle(.grayscale400)
                        .frame(height: 20)
                        .padding(.leading, 20)
                    
                    Text("\(viewModel.licenseCards.count)")
                        .foregroundStyle(.purpleblue)
                        .frame(height: 20)
                    
                    Text("개의 검색 결과")
                        .foregroundStyle(.grayscale400)
                        .frame(height: 20)
                    
                    Spacer()
                }
                .padding(.top, 12)
                
                CategorySearchLicenseCardList(viewModel: viewModel)
                    .padding(.top, 16)
            }
            .scrollIndicators(.hidden)
            .simultaneousGesture(TapGesture().onEnded {
                hideKeyboard()
            })
        }
    }
    
    private var CategoryEmptySearchResultView: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("총 ")
                    .foregroundStyle(.grayscale400)
                    .frame(height: 20)
                    .padding(.leading, 20)
                
                Text("0")
                    .foregroundStyle(.purpleblue)
                    .frame(height: 20)
                
                Text("개의 검색 결과")
                    .foregroundStyle(.grayscale400)
                    .frame(height: 20)
                
                Spacer()
            }
            .padding(.top, 12)
            
            Image(.imageEmpty)
                .padding(.top, 103.5)
            
            HStack(spacing: 0) {
                Text(viewModel.trimmedInput)
                    .foregroundStyle(.purpleblue)
                    .frame(height: 20)
                
                Text("에")
                    .foregroundStyle(.grayscale400)
                    .frame(height: 20)
            }
            .padding(.top, 20)
            
            Text("해당하는 결과가 없어요.")
                .foregroundStyle(.grayscale400)
                .frame(height: 20)
            
            Spacer()
        }
    }
}
