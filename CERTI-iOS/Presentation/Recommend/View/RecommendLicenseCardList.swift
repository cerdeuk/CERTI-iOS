//
//  RecommendLicenseCardList.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/8/25.
//

import SwiftUI

struct RecommendLicenseCardList: View {
    
    @ObservedObject var viewModel: RecommendViewModel
    
    let columns = [
        GridItem(.fixed(335))
    ]
    
    var body: some View {
        VStack(alignment: .center) {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(viewModel.licenseCards) { item in
                        LicenseCardItem(model: item, onTapFavorite: {})
                            .padding(.top, 16)
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}
