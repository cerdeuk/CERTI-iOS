//
//  CertificateSearchList.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/8/25.
//

import SwiftUI

struct CertificateSearchList: View {
    @ObservedObject var viewModel: CertificateViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 12) {
                    
                    ForEach(viewModel.searchLicenseCards) { item in
                        CertificateListTile(
                            title: item.title,
                            type: item.type,
                            description: item.description,
                            tags: item.tags,
                            testType: item.testType,
                            isFavorite: item.isFavorite
                        ) {
                            Task {
                                await viewModel.toggleFavorite(id: item.id)
                            }
                        }
                    }
                    
                }
                .padding(.bottom, 63)
            }
            .scrollIndicators(.hidden)
        }
    }
}
