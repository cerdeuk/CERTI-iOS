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
                            MyCertificateEditItems(isDeleteAlertPresented: $isDeleteAlertPresented, cardImage: dummy.cardFrontImageUrl, name: dummy.name, date: dummy.createdAt, certiTag: dummy.tag)
                        }
                    }
                    .frame(width: 248)
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

extension MyCertificateEditView {
    struct MyCertificateEditItems: View {
        @Binding var isDeleteAlertPresented: Bool
        
        var cardImage: String = ""
        var name: String = ""
        var date: String = ""
        var certiTag: [String]
        
        var body: some View {
            HStack {
                ZStack(alignment: .top) {
                    Image(cardImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 300)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text(name)
                            .foregroundStyle(.grayscale600)
                            .applyCertiFont(.caption_bold_14)
                            .frame(height: 20)
                            .padding(.top, 32)
                        
                        Text(date)
                            .applyCertiFont(.caption_regular_12)
                            .foregroundStyle(.grayscale600)
                            .frame(height: 18)
                            .padding(.top, 4)
                        
                        TagChip(tags: certiTag, spacing: 4)
                            .padding(.top, 8)
                            .frame(height: 23)
                    }
                }
                
                Button {
                    isDeleteAlertPresented = true
                } label: {
                    Image(.iconClose36)
                }
                .padding(.leading, 12)
                
                Spacer()
            }
        }
    }
}

#Preview {
    MyCertificateEditView()
}
