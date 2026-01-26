//
//  MyActivityWriteView.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/13/25.
//

import SwiftUI

struct MyActivityWriteView: View {
    @ObservedObject var viewModel: ResumeViewModel
    let mode: ActivityWriteMode

    var body: some View {
            VStack (alignment: .leading, spacing: 0) {
                BackButton() {
                    viewModel.resumeViewRoutePop()
                }
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        MyExtracurricularActivityTitleView
                        activityPeriodView
                        PeriodInputComponent(
                            isFilled: $viewModel.isPeriodFilled,
                            startAt: $viewModel.activityWriteModel.startAt,
                            endAt: $viewModel.activityWriteModel.endAt
                        )
                        organizeView
                        activityView
                        activityDetailView
                        ResumeWriteButton(
                            action: {
                                Task {
                                    switch mode {
                                    case .add:
                                        await viewModel.addActivity(activityWriteModel: viewModel.activityWriteModel)
                                    case .edit(let activityId):
                                        await viewModel.editActivity(activityId: activityId, activityWriteModel: viewModel.activityWriteModel)
                                    }
                                    viewModel.resumeViewRoutePop()
                                }
                            }, buttonText: mode == .add ? "추가하기" : "수정하기",
                            textEmpty: .constant(viewModel.isActivityWriteButtonEnabled)
                        )
                        .padding(.top, 40)
                    }
                }
                .onAppear{
                    switch mode {
                    case .add:
                        viewModel.clearActivityWriteModel()
                    case .edit(let activityId):
                        viewModel.prepareActivityEdit(activityId: activityId)
                    }
                }
                .navigationBarBackButtonHidden()
                .scrollIndicators(.hidden)
                .scrollDismissesKeyboard(.immediately)
            }
    }
}

extension MyActivityWriteView {
    private var MyExtracurricularActivityTitleView: some View {
        Group {
            HStack(alignment: .center, spacing: 0) {
                Text(mode == .add ? "대내외 활동 추가" : "대내외 활동 수정")
                    .applyCertiFont(.sub_semibold_20)
                    .foregroundStyle(.grayscale600)
                    .frame(height: 26)
                    .padding(.leading, 20)
                    .padding(.top, 24)
                
                Spacer()
            }
        }
    }
    
    private var activityPeriodView: some View {
        Group {
            HStack(alignment: .center, spacing: 0) {
                Image(.iconCheck24)
                    .padding(.trailing, 4)
                
                Text("기간")
                    .applyCertiFont(.body_semibold_18)
                    .foregroundStyle(.grayscale600)
                    .frame(height: 22)
                
                Spacer()
            }
            .frame(height: 24)
            .padding(.leading, 20)
            .padding(.bottom, 24)
            .padding(.top, 24)
        }
    }
    
    private var organizeView: some View {
        Group {
            HStack(alignment: .center, spacing: 0) {
                Image(.iconCheck24)
                    .padding(.trailing, 4)
                
                Text("소속")
                    .applyCertiFont(.body_semibold_18)
                    .foregroundStyle(.grayscale600)
                    .frame(height: 22)
                
                Spacer()
            }
            .frame(height: 24)
            .padding(.leading, 20)
            .padding(.bottom, 24)
            .padding(.top, 36)
            
            CharLimitTextField(text: $viewModel.activityWriteModel.name, maxLength: 10)
                .padding(.horizontal, 20)
        }
    }
    
    private var activityView: some View {
        Group {
            HStack(alignment: .center, spacing: 0) {
                Image(.iconCheck24)
                    .padding(.trailing, 4)
                
                Text("활동")
                    .applyCertiFont(.body_semibold_18)
                    .foregroundStyle(.grayscale600)
                    .frame(height: 22)
                
                Spacer()
            }
            .frame(height: 24)
            .padding(.leading, 20)
            .padding(.bottom, 24)
            .padding(.top, 36)
            
            CharLimitTextField(text: $viewModel.activityWriteModel.place, maxLength: 10)
                .padding(.horizontal, 20)
        }
    }
    
    private var activityDetailView: some View {
        Group {
            HStack(alignment: .center, spacing: 0) {
                Image(.iconCheck24)
                    .padding(.trailing, 4)
                
                Text("활동 관련 내용")
                    .applyCertiFont(.body_semibold_18)
                    .foregroundStyle(.grayscale600)
                    .frame(height: 22)
                
                Spacer()
            }
            .frame(height: 24)
            .padding(.leading, 20)
            .padding(.bottom, 24)
            .padding(.top, 36)
            
            CharLimitTextField(text: $viewModel.activityWriteModel.description, maxLength: 16)
                .padding(.horizontal, 20)
                .padding(.bottom, 16)
        }
    }
}
