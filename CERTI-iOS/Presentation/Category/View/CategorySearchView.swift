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
    @State private var searchPerformed: Bool = false

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
                    searchPerformed = true
                }
                    .padding(.horizontal, 20)
                    .padding(.top, 24)
                
                if searchPerformed {
                    renderSearchResult(for: inputText)
                }
                
                Spacer()
                
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

extension CategorySearchView {
    func renderSearchResult(for text: String) -> some View {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        
        return Group {
            if trimmed == "뿡" {
                CategoryEmptySearchResultView(searchQuery: trimmed)
                    .padding(.top, 24)
            } else if trimmed == "똥" {
                CategorySearchResultView()
                    .padding(.top, 24)
            }
        }
    }
}
