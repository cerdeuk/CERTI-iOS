//
//  MyCertificateEditView.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/11/25.
//

import SwiftUI

struct MyCertificateEditView: View {
    @EnvironmentObject var resumeCoordinator: ResumeCoordinator
    @State private var isDeleteAlertPresented = false
    
    let columns = [
        GridItem(.fixed(248))
    ]
    let CertificatedDummy: [CertificatedModel] = CertificatedModel.dummy()
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                BackButton {
                    resumeCoordinator.pop()
                }
                
                Text("취득한 자격증")
                    .applyCertiFont(.sub_semibold_20)
                    .foregroundStyle(.grayscale600)
                    .frame(height: 26)
                    .padding(.top, 24)
                    .padding(.leading, 20)
                
                ScrollView(.vertical) {
                    LazyVGrid(columns: columns, spacing: 24) {
                        ForEach(CertificatedDummy) { dummy in
                            HStack {
                                CeritificateCardComponent(cardImage: dummy.cardFrontImageUrl, name: dummy.name, date: dummy.createdAt, certiTag: dummy.tag)
                                
                                Button {
                                    isDeleteAlertPresented.toggle()
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
                .scrollIndicators(.hidden)
                .padding(.top, 36)
                .padding(.leading, 20)
                
            }
            if isDeleteAlertPresented {
                CertiDeleteAlertView {
                    isDeleteAlertPresented = false
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

#Preview {
    MyCertificateEditView()
}
