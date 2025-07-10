//
//  CategoryEmptySearchResultView.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/10/25.
//

import SwiftUI

struct CategoryEmptySearchResultView: View {
    let searchQuery: String
    
    var body: some View {
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
            
            Image(.imageEmpty)
                .padding(.top, 103.5)
            
            HStack(spacing: 0) {
                Text("\(searchQuery)")
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
