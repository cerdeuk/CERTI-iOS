//
//  CertificateDetailTabContainerView.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 1/7/26.
//

import SwiftUI

struct CertificateDetailTabContainerView: View {
    @ObservedObject var viewModel: CertificateDetailViewModel

    @State private var selectedTab: DetailTab = .detailInformation
    
    @Binding var certificationId: Int
    
    let onBack: () -> Void

    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 0) {
                BackButton {
                    onBack()
                }
                
                CertificateDetailTab(selectedTab: $selectedTab)
                    .frame(height: 50)
                    .padding(.leading, 20)
                    .padding(.top, 8)
                
                TabView(selection: $selectedTab) {
                    CertificateDetailView(viewModel: viewModel, certificationId: $certificationId)
                        .tag(DetailTab.detailInformation)
                    
                    CertificateCommentView(viewModel: viewModel, isSelectedPopularity: $viewModel.isSelectedPopularity, totalCommentCount: $viewModel.commentCount, certificationId: $certificationId)
                        .tag(DetailTab.comment)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
            .navigationBarBackButtonHidden(true)
            
            if viewModel.showCompleteModal {
                ZStack {
                    Color.blackOpacity40
                        .onTapGesture {
                            viewModel.showCompleteModal = false
                        }
                    CertificationDetailCompleteModalView(certificationName: viewModel.certificateDetailModel.certificationName)
                }
                .ignoresSafeArea()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}
