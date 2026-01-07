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
                
                CertificateCommentView()
                    .tag(DetailTab.comment)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var certificationId = 1

        var body: some View {
            CertificateDetailTabContainerView(
                viewModel: CertificateDetailViewModel(
                    fetchCertificationDetailUseCase: PreviewFetchCertificationDetailUseCase(),
                    addPreCertificationUseCase: PreviewAddPreCertificationUseCase(),
                    addAcquisitionUseCase: PreviewAddAcquisitionUseCase()), certificationId: $certificationId,
                onBack: { }
            )
        }
    }

    return PreviewWrapper()
}
