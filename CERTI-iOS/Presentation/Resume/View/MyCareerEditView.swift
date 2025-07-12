//
//  MyCareerEditView.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/12/25.
//

import SwiftUI

struct MyCareerEditView: View {
    @EnvironmentObject var resumeCoordinator: ResumeCoordinator
    @State private var isDeleteAlertPresented = false
    
    let columns = [GridItem(.fixed(335))]
    let careerDummy: [MyCareerModel] = MyCareerModel.dummy()

    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                BackButton {
                    resumeCoordinator.pop()
                }
                
                Button {
                    //작성하기
                } label: {
                    HStack(spacing: 0) {
                        Image(systemName: "plus")
                            .frame(width: 24, height: 24)
                            .tint(.purpleblue)
                        
                        Text("작성하기")
                            .applyCertiFont(.body_bold_16)
                            .foregroundStyle(.purpleblue)
                            .frame(width: 56, height: 22)
                    }
                    .frame(width: 122, height: 48)
                    .background(.purplewhite)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .padding(.top, 16)
                .padding(.leading, 20)

                
                Text("경력사항 수정")
                    .applyCertiFont(.sub_semibold_20)
                    .foregroundStyle(.grayscale600)
                    .frame(height: 26)
                    .padding(.top, 24)
                    .padding(.leading, 20)
                
                LazyVGrid(columns: columns, spacing: 36) {
                    ForEach(careerDummy) { dummy in
                        HStack(spacing: 0) {
                            ResumeActivityListComponent(startAt: dummy.startAt, endAt: dummy.endAt, name: dummy.name, place: dummy.place, discription: dummy.discription)
                                .frame(height: 50)
                                .onTapGesture {
                                    //수정하기
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

#Preview {
    MyCareerEditView()
}
