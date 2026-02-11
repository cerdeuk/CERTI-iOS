//
//  CertificateSearchView.swift
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

struct CertificateSearchView: View {
    @ObservedObject var viewModel: CertificateViewModel
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    hideKeyboard()
                }
            
            VStack(spacing: 0) {
                BackButton {
                    viewModel.certificateViewRoutePop()
                }
                .padding(.bottom, 12)
                
                SearchBar(text: $viewModel.inputText) {
                    Task {
                        if viewModel.inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            viewModel.searchResult = .empty
                            return
                        }
                        
                        await viewModel.searchCertifiedList(keyword: viewModel.inputText)
                        
                        if viewModel.searchLicenseCards.isEmpty {
                            viewModel.searchResult = .noResult
                        } else {
                            viewModel.searchResult = .result
                        }
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
                
            }
        }
    }
    
    private var CategorySearchResultView: some View {
        ScrollView {
            VStack(spacing: 0) {
                HStack(alignment: .center, spacing: 0) {
                    Text("총 ")
                        .applyCertiFont(.caption_regular_14)
                        .foregroundStyle(.grayscale600)
                        .frame(height: 20)
                        .padding(.leading, 20)
                    
                    Text("\(viewModel.searchLicenseCards.count)")
                        .applyCertiFont(.caption_regular_14)
                        .foregroundStyle(.purpleblue)
                        .frame(height: 20)
                    
                    Text("개의 검색 결과")
                        .applyCertiFont(.caption_regular_14)
                        .foregroundStyle(.grayscale600)
                        .frame(height: 20)
                    
                    Spacer()
                }
                .padding(.top, 12)
                
                CertificateSearchList(viewModel: viewModel)
                    .padding(.top, 16)
            }
        }
        .scrollIndicators(.hidden)
        .simultaneousGesture(TapGesture().onEnded {
            hideKeyboard()
        })
    }
    
    private var CategoryEmptySearchResultView: some View {
        VStack(alignment: .center, spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                Text("총 ")
                    .applyCertiFont(.caption_regular_14)
                    .foregroundStyle(.grayscale600)
                    .frame(height: 20)
                    .padding(.leading, 20)
                
                Text("0")
                    .applyCertiFont(.caption_regular_14)
                    .foregroundStyle(.purpleblue)
                    .frame(height: 20)
                
                Text("개의 검색 결과")
                    .applyCertiFont(.caption_regular_14)
                    .foregroundStyle(.grayscale600)
                    .frame(height: 20)
                
                Spacer()
            }
            .padding(.top, 12)
            
            Image(.imageEmpty)
                .padding(.top, 103.5)
            
            HStack(alignment: .center, spacing: 0) {
                Text(viewModel.trimmedInput)
                    .applyCertiFont(.caption_regular_14)
                    .foregroundStyle(.purpleblue)
                    .frame(height: 20)
                
                Text("에")
                    .applyCertiFont(.caption_regular_14)
                    .foregroundStyle(.grayscale400)
                    .frame(height: 20)
            }
            .padding(.top, 20)
            
            Text("해당하는 결과가 없어요.")
                .applyCertiFont(.caption_regular_14)
                .foregroundStyle(.grayscale400)
                .frame(height: 20)
            
            Spacer()
        }
    }
}
