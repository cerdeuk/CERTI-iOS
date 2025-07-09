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
    @FocusState private var isTextFieldFocused: Bool

    var body: some View {
        ZStack {
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    isTextFieldFocused = false
                }
            
            VStack(spacing: 0) {
                BackButton {
                    categoryCoordinator.pop()
                }
                
                SearchBar(isFocused: $isTextFieldFocused, text: $inputText)
                    .padding(.horizontal, 20)
                    .padding(.top, 24)
                
                Spacer()
                
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
