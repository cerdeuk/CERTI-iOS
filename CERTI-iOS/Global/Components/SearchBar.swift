//
//  SearchBar.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/10/25.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var onSearchTapped: () -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .stroke(.grayscale300, lineWidth: 1)
            
            HStack(alignment: .center, spacing: 0) {
                TextField(
                    "", text: $text,
                    prompt: Text("검색어를 입력해주세요.")
                        .foregroundColor(.grayscale300)
                )
                .maxLength(30, text: $text)
                .applyCertiFont(.body_regular_16)
                .frame(height: 22)
                .foregroundColor(.black)
                .blackCursor()
                .onSubmit {
                    onSearchTapped()
                }
                
                Button {
                    onSearchTapped()
                } label: {
                    Image(.iconSearch24)
                }
            }
            .padding(.vertical, 16)
            .padding(.horizontal,12)
        }
        .frame(height: 56)
    }
}
    
