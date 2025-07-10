//
//  CategorySearchView.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/6/25.
//

import SwiftUI

struct CategorySearchView: View {
    @EnvironmentObject var categoryCoordinator: CategoryCoordinator
    @State private var inputText: String = ""
    @State private var searchResult: SearchResultType? = nil

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
                
                SearchBar(text: $inputText) {
                    if inputText.isEmpty {
                        searchResult = .empty
                    } else if inputText.trimmingCharacters(in: .whitespacesAndNewlines) == "뿡" {
                        searchResult = .noResult(inputText)
                    } else {
                        searchResult = .result
                    }
                }
                    .padding(.horizontal, 20)
                    .padding(.top, 24)
                
                if let result = searchResult {
                    switch result {
                    case .empty:
                        EmptyView()
                    case .noResult(let string):
                        CategoryEmptySearchResultView(searchQuery: string)
                            .padding(.top, 24)
                    case .result:
                        CategorySearchResultView()
                            .padding(.top, 24)
                    }
                }
                
                Spacer()
                
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

enum SearchResultType {
    case empty
    case noResult(String)
    case result
}
