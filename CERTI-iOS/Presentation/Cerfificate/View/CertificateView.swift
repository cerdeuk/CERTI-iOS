//
//  CertificateView.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/28/26.
//

import SwiftUI

struct CertificateView: View {
    @ObservedObject var viewModel: CertificateViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            header
            
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    
                    
                    
                }
            }
            .scrollIndicators(.hidden)
            
            
        }
    }
}


// MARK: - SubViews

private extension CertificateView {
    var header: some View {
        HStack(alignment: .bottom, spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                Rectangle()
                    .frame(width: 44, height: 24)
                    .foregroundStyle(.clear)
                
                Spacer()
                
                Text("모든 자격증")
                    .applyCertiFont(.sub_semibold_20)
                    .foregroundStyle(.grayscale600)
                
                Spacer()
                
                Button {
                    // 검색으로 이동
                } label: {
                    Image(.iconSearch24)
                }
                .padding(.trailing, 20)
            }
            .frame(height: 26)
            .padding(.bottom, 12)
        }
        .frame(height: 58)
    }
    
    
}

#Preview {
    @StateObject var viewModel = CertificateViewModel()
    
    CertificateView(viewModel: viewModel)
}
