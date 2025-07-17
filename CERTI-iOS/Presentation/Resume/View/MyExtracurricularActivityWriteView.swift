//
//  MyExtracurricularActivityWriteView.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/13/25.
//

import SwiftUI

struct MyExtracurricularActivityWriteView: View {
    @EnvironmentObject var resumeCoordinator: ResumeCoordinator
    @ObservedObject var viewModel: ResumeViewModel
    
    var body: some View {
        BackButton() {
            resumeCoordinator.pop()
        }
        
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                MyExtracurricularActivityTitleView
                activityPeriodView
                PeriodInputComponent(
                        isFilled: $viewModel.isPeriodFilled,
                        startAt: $viewModel.resumeModel.startAt,
                        endAt: $viewModel.resumeModel.endAt
                    )
                organizeView
                activityView
                activityDetailView
            }
        }
        .onAppear{
            viewModel.clearResumeModel()
        }
        .navigationBarBackButtonHidden()
        .scrollIndicators(.hidden)
        
        ResumeWriteButton(
            action: {
                Task {
                    await viewModel.addActivity(resumeModel: viewModel.resumeModel)
                    viewModel.clearResumeModel()
                    resumeCoordinator.pop()
                }
            },
            textEmpty: .constant(viewModel.isWriteButtonEnabled)
        )
        .padding(.bottom, 16)
    }
}

extension MyExtracurricularActivityWriteView {
    private var MyExtracurricularActivityTitleView: some View {
        Group {
            HStack(alignment: .center, spacing: 0) {
                Text("대내외 활동 추가")
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
            
            CharLimitTextField(text: $viewModel.resumeModel.name, maxLength: 10)
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
            
            CharLimitTextField(text: $viewModel.resumeModel.place, maxLength: 10)
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
            
            CharLimitTextField(text: $viewModel.resumeModel.discription, maxLength: 16)
                .padding(.horizontal, 20)
                .padding(.bottom, 16)
        }
    }
    
    private func testButtonClicked() {
        print("testButtonClicked")
    }
}
