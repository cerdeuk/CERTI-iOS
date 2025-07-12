//
//  RecommendView.swift
//  CERTI-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI

struct RecommendView: View {
    @EnvironmentObject var recommendCoordinator: RecommendCoordinator
    @StateObject private var viewModel = RecommendViewModel()
    
    let username = "김서티"
    
    var body: some View {
        
        VStack(spacing: 0) {
            RecommendViewHeader
            
            RecommendInterestTagBar()
                .padding(.top, 12)
            
            RecommendLicenseCardList(viewModel: viewModel)
        }
    }
    
    private var RecommendViewHeader: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                Group {
                    Text.trimmedUsername(username)
                    Text("님에게 추천하는 자격증")
                }
                .applyCertiFont(.sub_bold_20)
                .foregroundStyle(.grayscale600)
                .frame(height: 26)
                
                Spacer()
                
            }
            .padding(.leading, 20)
            .padding(.top, 36)
            
            Text("분아별 추천 자격증을 모아봤어요!")
                .applyCertiFont(.caption_regular_14)
                .foregroundStyle(.grayscale600)
                .padding(.leading, 20)
                .padding(.top, 8)
        }
    }
    
}
