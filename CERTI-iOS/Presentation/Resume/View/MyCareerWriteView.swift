//
//  MyCareerWriteView.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/13/25.
//

import SwiftUI

struct MyCareerWriteView: View {
    @EnvironmentObject var resumeCoordinator: ResumeCoordinator

    @State private var company: String = ""
    @State private var duty: String = ""
    @State private var detail: String = ""
    @State private var isPeriodFilled: Bool = false
    
    var isButtonEnabled: Bool {
        !company.isEmpty && !duty.isEmpty && !detail.isEmpty && isPeriodFilled
    }
    
    var body: some View {
        ScrollView{
            VStack(spacing: 0) {
                MyCareerWriteTitleView
                workingPeriodView
                PeriodInputComponent(isFilled: $isPeriodFilled)
                workingCompany
                dutyView
                dutyDetailView
                Spacer()
                ResumeWriteButton(action: testButtonClicked, textEmpty: .constant(isButtonEnabled))
                    .padding(.top, 16)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

extension MyCareerWriteView {
    private var MyCareerWriteTitleView: some View {
        VStack(alignment: .leading, spacing: 0) {
            BackButton() {
                resumeCoordinator.pop()
            }
            
            HStack(spacing: 0) {
                Text("경력사항 추가")
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
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                Image(.iconCheck24)
                    .padding(.trailing, 4)
                
                Text("근무기간")
                    .applyCertiFont(.body_semibold_18)
                    .foregroundStyle(.grayscale600)

                Spacer()
            }
            .padding(.leading, 20)
            .padding(.bottom, 14)
            .padding(.top, 24)
        }
    }
    
    private var workingCompany: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
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
            .padding(.top, 26)

            CharLimitTextField(text: $company, maxLength: 10)
                .padding(.horizontal, 20)
        }
    }
    
    private var dutyView: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
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
            
            CharLimitTextField(text: $duty, maxLength: 10)
                .padding(.horizontal, 20)
        }
    }
    
    private var dutyDetailView: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
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
            
            CharLimitTextField(text: $detail, maxLength: 16)
                .padding(.horizontal, 20)
        }
    }
    
    private func testButtonClicked() {
        print("testButtonClicked")
    }
}

#Preview {
    MyCareerWriteView()
}
