//
//  CertificateDetailTabContainerView.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 1/7/26.
//

import SwiftUI

struct CertificateDetailTabContainerView: View {
    @State private var selectedTab: DetailTab = .detailInformation
    @Binding private var certificationId: Int
    
    @StateObject private var viewModel: CertificateDetailViewModel

       init(
           certificationId: Binding<Int>,
           onBack: @escaping () -> Void
       ) {
           self._certificationId = certificationId
           self.onBack = onBack

           _viewModel = StateObject(wrappedValue: CertificateDetailViewModel(
               fetchCertificationDetailUseCase: PreviewFetchCertificationDetailUseCase(),
               addPreCertificationUseCase: PreviewAddPreCertificationUseCase(),
               addAcquisitionUseCase: PreviewAddAcquisitionUseCase()
           ))
       }
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
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var certificationId = 1

        var body: some View {
            CertificateDetailTabContainerView(
                certificationId: $certificationId,
                onBack: { }
            )
        }
    }

    return PreviewWrapper()
}
