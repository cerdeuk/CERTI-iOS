//
//  MyCertificateEditView.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/11/25.
//

import SwiftUI

struct MyCertificateEditView: View {
    @EnvironmentObject var resumeCoordinator: ResumeCoordinator
    @ObservedObject var viewModel: ResumeViewModel
    @State var isDeleteAlertPresented = false
    @State var selectedIndex : Int? = nil
    
    let columns = [GridItem(.flexible())]
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                BackButton {
                    resumeCoordinator.pop()
                }
                
                ScrollView(.vertical) {
                    VStack(alignment: .leading, spacing: 0) {
                    Text("취득한 자격증")
                        .applyCertiFont(.sub_semibold_20)
                        .foregroundStyle(.grayscale600)
                        .frame(height: 26)
                        .padding(.bottom, 36)
                    
                    LazyVGrid(columns: columns, spacing: 24) {
                        ForEach(viewModel.acquisitionList) { cardItem in
                            HStack(alignment: .center, spacing: 0) {
                                CeritificateCardComponent(model: cardItem)
                                
                                Button {
                                    isDeleteAlertPresented.toggle()
                                    selectedIndex = cardItem.acquisitionId
                                } label: {
                                    Image(.iconClose36)
                                }
                                .padding(.leading, 12)
                                
                                Spacer()
                            }
                        }
                    }
                    .frame(width: 264)
                }
                    .padding(.top, 24)
                }
                .scrollIndicators(.hidden)
                .padding(.leading, 20)
                
            }
            
            if isDeleteAlertPresented {
                CertiDeleteAlertView {
                    Task {
                        guard let deleteIndex = selectedIndex else { return }
                        await viewModel.deleteAcquisition(id: deleteIndex)
                    }
                    isDeleteAlertPresented = false
                    print("확인 버튼 클릭")
                } onCancel: {
                    isDeleteAlertPresented = false
                    print("취소버튼 클릭")
                }
            }
        }
        .onAppear{
            Task {
                await viewModel.getAcquisitionList()
            }
        }
        .navigationBarBackButtonHidden()
    }
}
