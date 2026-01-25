//
//  MyCareerWriteView.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/13/25.
//

import SwiftUI

struct MyCareerWriteView: View {
    @ObservedObject var viewModel: ResumeViewModel
    let mode: CareerWriteMode
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            BackButton() {
                viewModel.resumeViewRoutePop()
            }
            
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    MyCareerWriteTitleView
                    workingPeriodView
                    PeriodInputComponent(
                        isFilled: $viewModel.isPeriodFilled,
                        startAt: $viewModel.careerWriteModel.startAt,
                        endAt: $viewModel.careerWriteModel.endAt
                    )
                    workingCompany
                    dutyView
                    dutyDetailView
                    ResumeWriteButton(
                        action: {
                            Task {
                                switch mode {
                                case .add:
                                    await viewModel.addCareer(careerWriteModel: viewModel.careerWriteModel)
                                case .edit(let careerId):
                                    await viewModel.editCareer(careerId: careerId, careerWriteModel: viewModel.careerWriteModel)
                                }
                                viewModel.resumeViewRoutePop()
                            }
                        },
                        textEmpty: .constant(viewModel.isCareerWriteButtonEnabled)
                    )
                    .padding(.top, 40)
                }
            }
            .onAppear{
                switch mode {
                case .add:
                    viewModel.clearCareerWriteModel()
                case .edit(let careerId):
                    viewModel.prepareCareerEdit(careerId: careerId)
                }
            }
            .scrollIndicators(.hidden)
            .navigationBarBackButtonHidden()
            .scrollDismissesKeyboard(.immediately)
        }
    }
}

extension MyCareerWriteView {
    private var MyCareerWriteTitleView: some View {
        Group {
            HStack(alignment: .center, spacing: 0) {
                Text(mode == .add ? "경력사항 추가" : "경력사항 수정")
                    .applyCertiFont(.sub_semibold_20)
                    .foregroundStyle(.grayscale600)
                    .frame(height: 26)
                    .padding(.leading, 20)
                    .padding(.top, 24)
                
                Spacer()
            }
        }
    }
    
    private var workingPeriodView: some View {
        Group {
            HStack(alignment: .center, spacing: 0) {
                Image(.iconCheck24)
                    .padding(.trailing, 4)
                
                Text("근무기간")
                    .applyCertiFont(.body_semibold_18)
                    .foregroundStyle(.grayscale600)
                
                Spacer()
            }
            .padding(.leading, 20)
            .padding(.bottom, 24)
            .padding(.top, 24)
        }
    }
    
    private var workingCompany: some View {
        Group {
            HStack(alignment: .center, spacing: 0) {
                Image(.iconCheck24)
                    .padding(.trailing, 4)
                
                Text("근무회사")
                    .applyCertiFont(.body_semibold_18)
                    .foregroundStyle(.grayscale600)
                    .frame(height: 22)
                
                Spacer()
            }
            .padding(.leading, 20)
            .padding(.bottom, 24)
            .padding(.top, 36)
            
            CharLimitTextField(text: $viewModel.careerWriteModel.name, maxLength: 10)
                .padding(.horizontal, 20)
        }
    }
    
    private var dutyView: some View {
        Group {
            HStack(alignment: .center, spacing: 0) {
                Image(.iconCheck24)
                    .padding(.trailing, 4)
                
                Text("직무")
                    .applyCertiFont(.body_semibold_18)
                    .foregroundStyle(.grayscale600)
                    .frame(height: 22)
                
                Spacer()
            }
            .padding(.leading, 20)
            .padding(.bottom, 24)
            .padding(.top, 36)
            
            CharLimitTextField(text: $viewModel.careerWriteModel.place, maxLength: 10)
                .padding(.horizontal, 20)
        }
    }
    
    private var dutyDetailView: some View {
        Group {
            HStack(alignment: .center, spacing: 0) {
                Image(.iconCheck24)
                    .padding(.trailing, 4)
                
                Text("직무 관련 내용")
                    .applyCertiFont(.body_semibold_18)
                    .foregroundStyle(.grayscale600)
                    .frame(height: 22)
                
                Spacer()
            }
            .padding(.leading, 20)
            .padding(.bottom, 24)
            .padding(.top, 36)
            
            CharLimitTextField(text: $viewModel.careerWriteModel.description, maxLength: 16)
                .padding(.horizontal, 20)
        }
    }
    
    private func testButtonClicked() {
        print("testButtonClicked")
    }
}
