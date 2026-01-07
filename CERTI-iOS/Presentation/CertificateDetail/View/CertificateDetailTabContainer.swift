//
//  CertificateDetailTabContainer.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 1/7/26.
//

import SwiftUI

struct CertificateDetailTabContainer: View {
    @State private var selectedTab: DetailTab = .detailInformation
    @State private var certificationId: Int
    
    private let viewModel = CertificateDetailViewModel(
        fetchCertificationDetailUseCase: PreviewFetchCertificationDetailUseCase(),
        addPreCertificationUseCase: PreviewAddPreCertificationUseCase(),
        addAcquisitionUseCase: PreviewAddAcquisitionUseCase())
    
    let onBack: () -> Void

    var body: some View {
        TabView(selection: $selectedTab) {
            CertificateDetailView(viewModel: viewModel, certificationId: $certificationId, onBack: onBack)
                .tag(DetailTab.detailInformation)
            
//            CertificateCommentPage()
//                .tag(DetailTab.comment)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var certificationId = 1

        var body: some View {
            CertificateDetailView(
                viewModel: CertificateDetailViewModel(
                    fetchCertificationDetailUseCase: PreviewFetchCertificationDetailUseCase(),
                    addPreCertificationUseCase: PreviewAddPreCertificationUseCase(),
                    addAcquisitionUseCase: PreviewAddAcquisitionUseCase()
                ),
                certificationId: $certificationId,
                onBack: {}
            )
        }
    }

    return PreviewWrapper()
}
