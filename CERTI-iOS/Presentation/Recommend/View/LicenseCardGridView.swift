//
//  LicenseCardGridView.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/8/25.
//

import SwiftUI

struct LicenseCardGridView: View {
    @StateObject var viewModel = LicenseCardViewModel()
    let columns = [
        GridItem(.fixed(335))
    ]
    var body: some View {
        VStack(alignment: .center) {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(viewModel.licenseCards) { item in
                        LicenseCardGridItemView(model: item,
                                                onTapFavorite: {
                            viewModel.toggleFavorite(id: item.id)
                        }
                        )
                    }
                }
            }
        }
    }
}

#Preview {
    LicenseCardGridView()
}
