//
//  MyExtracurricularActivityEditView.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/13/25.
//

import SwiftUI

struct MyExtracurricularActivityEditView: View {
    @EnvironmentObject var resumeCoordinator: ResumeCoordinator
    @ObservedObject var viewModel: ResumeViewModel
    @State var isDeleteAlertPresented = false
    
    let columns = [GridItem(.flexible())]
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                BackButton {
                    resumeCoordinator.pop()
                }
                
                Button {
                    resumeCoordinator.push(next: .myExtracurricularActivityWriteView)
                } label: {
                    HStack(alignment: .center, spacing: 0) {
                        Image(.iconPlus)
                            .frame(width: 24, height: 24)
                            .padding(.trailing, 2)
                        
                        Text("작성하기")
                            .applyCertiFont(.body_bold_16)
                            .foregroundStyle(.purpleblue)
                            .frame(width: 56, height: 22)
                    }
                    .frame(width: 122, height: 48)
                    .background(.purplewhite)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .padding(.top, 44)
                .padding(.leading, 20)
                
                
                Text("대내외 활동 수정")
                    .applyCertiFont(.sub_semibold_20)
                    .foregroundStyle(.grayscale600)
                    .frame(height: 26)
                    .padding(.top, 32)
                    .padding(.leading, 20)
                
                LazyVGrid(columns: columns, spacing: 36) {
                    ForEach(viewModel.myExtracurricularActivityModelDummy) { dummy in
                        HStack(alignment: .center, spacing: 0) {
                            ResumeActivityListComponent(model: dummy)
                                .frame(height: 50)
                                .onTapGesture {
                                    resumeCoordinator.push(next: .myExtracurricularActivityWriteView)
                                }
                            
                            Button {
                                isDeleteAlertPresented.toggle()
                            } label: {
                                Image(.iconClose36)
                            }
                            .padding(.leading, 29)
                        }
                    }
                }
                .padding(.top, 36)
                .padding(.horizontal, 20)
                
                Spacer()
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
