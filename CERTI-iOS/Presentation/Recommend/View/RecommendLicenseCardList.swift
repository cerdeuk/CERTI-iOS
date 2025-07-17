//
//  RecommendLicenseCardList.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/8/25.
//

import SwiftUI

struct RecommendLicenseCardList: View {
    
    @EnvironmentObject var recommendCoordinator: RecommendCoordinator
    @ObservedObject var viewModel: RecommendViewModel
    
    let columns = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack(alignment: .center) {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(viewModel.licenseCards) { item in
                        LicenseCardItem(model: item,
                                                onTapFavorite: {
                            Task{
                                viewModel.toggleFavorite(id: item.id)
                            }
                        },
                                        onTapCard: {
                            viewModel.selectCertificate(id: item.id)
                            DispatchQueue.main.async {
                                recommendCoordinator.push(next: .detail(id: item.id, beforeViewType: .recommend))
                            }
                            Task { @MainActor in
                                recommendCoordinator.push(next: .detail(id: item.id, beforeViewType: .recommend))
                            }
                        }
                        )
                    }
                }
                .padding(.top, 16)
                .padding(.bottom, 63)
            }
            .scrollIndicators(.hidden)
        }
    }
}
