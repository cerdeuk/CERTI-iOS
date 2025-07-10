//
//  CategorySearchResultView.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/10/25.
//

import SwiftUI

struct CategorySearchResultView: View {
    @StateObject private var viewModel = CategoryViewModel()

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                HStack(spacing: 0) {
                    Text("총 ")
                        .foregroundStyle(.grayscale400)
                        .frame(height: 20)
                        .padding(.leading, 20)
                    
                    Text("3")
                        .foregroundStyle(.purpleblue)
                        .frame(height: 20)
                    
                    Text("개의 검색 결과")
                        .foregroundStyle(.grayscale400)
                        .frame(height: 20)
                    
                    Spacer()
                }
                .padding(.top, 12)
                
                CategoryLicenseCardList(viewModel: viewModel)
                    .padding(.top, 16)
            }
        }
    }
}
