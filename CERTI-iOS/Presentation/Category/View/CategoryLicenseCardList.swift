//
//  CategoryLicenseCardList.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/8/25.
//

import SwiftUI

struct CategoryLicenseCardList: View {
    
    @ObservedObject var viewModel: CategoryViewModel
    
    let columns = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(viewModel.licenseCards) { item in
                        LicenseCardItem(model: item,
                                                onTapFavorite: {
                            Task{
                                await viewModel.postFavorite(certificationId: item.certificationId)
                            }
                            viewModel.toggleFavorite(id: item.id)
                        }
                        )
                    }
                }
                .padding(.bottom, 63)
            }
            .scrollIndicators(.hidden)
        }
    }
}
