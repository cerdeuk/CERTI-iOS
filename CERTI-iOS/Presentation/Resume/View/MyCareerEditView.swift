//
//  MyCareerEditView.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/12/25.
//

import SwiftUI

struct MyCareerEditView: View {
    @EnvironmentObject var resumeCoordinator: ResumeCoordinator
    @ObservedObject var viewModel: ResumeViewModel
    @State var isDeleteAlertPresented = false
    @State var selectedCareersIndex : Int? = nil
    
    let columns = [GridItem(.flexible())]
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                BackButton {
                    resumeCoordinator.pop()
                }
                
                Button {
                    resumeCoordinator.push(next: .myCareerWriteView)
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
                
                Text("경력사항 수정")
                    .applyCertiFont(.sub_semibold_20)
                    .foregroundStyle(.grayscale600)
                    .frame(height: 26)
                    .padding(.top, 32)
                    .padding(.leading, 20)
                
                LazyVGrid(columns: columns, spacing: 36) {
                    ForEach(viewModel.careersList) { item in
                        HStack(alignment: .center, spacing: 0) {
                            ResumeActivityListComponent(model: item)
                                .frame(height: 50)
                            
                            Button {
                                isDeleteAlertPresented.toggle()
                                selectedCareersIndex = item.careerId
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
                    Task {
                        guard let deleteIndex = selectedCareersIndex else { return }
                        await viewModel.deleteCareers(id: deleteIndex)
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
                await viewModel.getCareersList()
            }
        }
        .navigationBarBackButtonHidden()
    }
}
