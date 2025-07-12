//
//  HomeDetailView.swift
//  CERTI-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI

struct PreLicenseEditView: View {
    @EnvironmentObject var homeCoordinator: HomeCoordinator

    @Binding var preLicenses: [PreLicenseCardModel]

    @State private var isDeleteAlertPresented = false
        
    let columns = [GridItem(.fixed(132))]
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .center, spacing: 0) {
                    Button {
                        homeCoordinator.pop()
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
                        ForEach(preLicenses, id: \.certificationId) { dummy in
                            HStack(alignment: .center, spacing: 12) {
                                PreLicenseCard(licenseCard: dummy)
                                    .shadow(color: .black.opacity(0.08), radius: 12, x: 4, y: 4)
                                
                                Button {
                                    // 취득 예정 자격증 삭제
                                    isDeleteAlertPresented = true
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
                    isDeleteAlertPresented = false
                    preLicenses.removeLast()
                    print("확인 버튼 클릭")
                } onCancel: {
                    isDeleteAlertPresented = false
                    print("취소버튼 클릭")
                }
                
            }
        }
        .navigationBarBackButtonHidden()
    }
}
