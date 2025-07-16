//
//  CategorySearchLicenseCardList.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/8/25.
//

import SwiftUI

struct CategorySearchLicenseCardList: View {
    
    @EnvironmentObject var categoryCoordinator: CategoryCoordinator
    @ObservedObject var viewModel: CategoryViewModel
    
    let columns = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(viewModel.searchLicenseCards) { item in
                        LicenseCardItem(model: item,
                                        onTapFavorite: {
                            Task{
                                await viewModel.postFavorite(certificationId: item.certificationId)
                            }
                            viewModel.toggleSearchFavorite(id: item.id)
                        },
                                        onTapCard: {
                            viewModel.selectCertificate(id: item.id)
                            DispatchQueue.main.async {
                                categoryCoordinator.push(next: .detail(id: item.id, beforeViewType: .category))
                            }
                        }
                        )
                    }
                }
                .padding(.bottom, 1)
            }
        }
    }
}
