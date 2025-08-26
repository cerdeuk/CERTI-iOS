//
//  OnboardingGradeView.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/12/25.
//

import SwiftUI

struct OnboardingGradeView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    private let gradeOptions = ["1학년", "2학년", "3학년", "4학년 이상", "졸업/졸업유예"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            BackButton {
                viewModel.onboardingViewRoutePop()
            }
            .padding(.bottom, 13)
            
            Image(.onboardingProgressbar2)
                .padding(.leading, 20)
                .padding(.bottom, 40)
            
            Text("현재 학년을 선택해주세요")
                .applyCertiFont(.sub_bold_20)
                .foregroundStyle(.grayscale600)
                .padding(.leading, 20)
                .padding(.bottom, 58)
            
            VStack(spacing: 12) {
                ForEach(gradeOptions, id: \.self) { grade in
                    Button {
                        if viewModel.selectedGrade == grade {
                            viewModel.selectedGrade = ""
                        } else {
                            viewModel.selectedGrade = grade
                        }
                    } label: {
                        Text(grade)
                            .applyCertiFont(viewModel.selectedGrade == grade ? .body_semibold_16 : .body_regular_16)
                            .foregroundColor(viewModel.selectedGrade == grade ? .grayscale600 : .grayscale500)
                            .frame(maxWidth: .infinity, minHeight: 56)
                            .background(viewModel.selectedGrade == grade ? .lightblue : .bluewhite)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(viewModel.selectedGrade == grade ? .skyblue : .lightblue , lineWidth: 1)
                            }
                    }
                }
            }
            .padding(.horizontal, 20)
            
            Spacer()
            
            Button {
                viewModel.navigateToTrack()
            } label: {
                Text("다음")
                    .applyCertiFont(.body_semibold_16)
                    .foregroundColor(viewModel.selectedGrade.isEmpty ? .grayscale400 : .white)
                    .frame(maxWidth: .infinity, minHeight: 56)
                    .background(viewModel.selectedGrade.isEmpty ? .grayscale100 : .purpleblue)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .disabled(viewModel.selectedGrade.isEmpty)
            .padding(.horizontal, 20)
            .padding(.bottom, 22)
            
        }
    }
}
