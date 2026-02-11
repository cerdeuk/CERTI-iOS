//
//  MyCertificateEditView.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/11/25.
//

import SwiftUI

struct MyCertificateEditView: View {
    @ObservedObject var viewModel: ResumeViewModel
    
    let columns = [GridItem(.flexible())]
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                BackButton {
                    viewModel.resumeViewRoutePop()
                }
                
                ScrollView(.vertical) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("취득한 자격증")
                            .applyCertiFont(.sub_semibold_20)
                            .foregroundStyle(.grayscale600)
                            .frame(height: 26)
                            .padding(.bottom, 8)
                        
                        Text("자격증 편집은 마이페이지> 자격증 관리에서 가능합니다.")
                            .applyCertiFont(.caption_regular_14)
                            .foregroundStyle(.grayscale400)
                            .frame(height: 20)
                            .padding(.bottom, 24)

                        LazyVGrid(columns: columns, spacing: 24) {
                            ForEach(viewModel.acquisitionList) { cardItem in
                                HStack(alignment: .center, spacing: 0) {
                                    CeritificateCardComponent(model: cardItem)
                                    
                                    Spacer()
                                }
                            }
                        }
                        .frame(width: 264)
                    }
                    .padding(.top, 24)
                }
                .scrollIndicators(.hidden)
                .padding(.leading, 20)
                
            }
        }
        .onAppear{
            Task {
                await viewModel.getAcquisitionList()
            }
        }
        .navigationBarBackButtonHidden()
    }
}
