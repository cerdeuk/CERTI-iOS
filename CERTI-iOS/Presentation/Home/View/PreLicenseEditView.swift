//
//  HomeDetailView.swift
//  CERTI-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI

struct PreLicenseEditView: View {
    @ObservedObject var viewModel: HomeViewModel

    @State private var isDeleteAlertPresented = false
    @State private var selectedIndex: Int? = nil
        
    let columns = [GridItem(.fixed(132))]
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .center, spacing: 0) {
                    Button {
                        viewModel.homeViewRoutePop()
                    } label: {
                        Image(.iconArrowleft36)
                    }
                    Spacer()
                }
                .padding(.leading, 20)
                .padding(.top, 16)
                .padding(.bottom, 24)
                
                Text("취득 예정 자격증")
                    .applyCertiFont(.sub_semibold_20)
                    .foregroundStyle(.grayscale600)
                    .frame(height: 26)
                    .padding(.leading, 20)
                
                ScrollView(.vertical) {
                    LazyVGrid(columns: columns, alignment:.leading, spacing: 0) {
                        ForEach(viewModel.homeStateModel.preLicenses) { item in
                            HStack(alignment: .center, spacing: 12) {
                                PreLicenseCard(licenseCard: item)
                                    .shadow(color: .black.opacity(0.08), radius: 12, x: 4, y: 4)
                                
                                Button {
                                    // 취득 예정 자격증 삭제
                                    isDeleteAlertPresented = true
                                    selectedIndex = item.certificationId
                                } label: {
                                    Image(.iconClose36)
                                }
                            }
                            .padding(.top, 36)
                            .padding(.leading, 20)
                        }
                    }
                }
                .scrollIndicators(.hidden)
                
            }
            
            if isDeleteAlertPresented {
                CertiDeleteAlertView {
                    Task {
                        guard let deleteIndex = selectedIndex else { return }
                        await viewModel.deletePreCertification(id: deleteIndex)
                    }
                    isDeleteAlertPresented = false
                    print("확인 버튼 클릭")
                } onCancel: {
                    isDeleteAlertPresented = false
                    print("취소버튼 클릭")
                }
                
            }
        }
    }
}
