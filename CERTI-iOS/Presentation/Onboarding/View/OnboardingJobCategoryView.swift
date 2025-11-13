//
//  OnboardingJobCategoryView.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/12/25.
//

import SwiftUI

struct OnboardingJobCategoryView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    @State private var step: Int = 1
    @State private var selectedJob: String = ""
    
    private let jobOptions = ["경영/사무", "마케팅/광고/홍보", "무역/유통", "IT/인터넷", "생산/제조", "영업/고객상담", "건설", "금융", "연구개발/설계", "디자인", "미디어", "전문/특수직"]
    
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            BackButton {
                viewModel.onboardingViewRoutePop()
            }
            .padding(.bottom, 13)
            
            Image(.onboardingProgressbar5)
                .padding(.leading, 20)
                .padding(.bottom, 40)
            
            HStack(alignment: .center, spacing: 0) {
                Text("\(step)순위 ")
                    .applyCertiFont(.sub_bold_20)
                    .foregroundStyle(.mainblue)
                
                Text("희망직무를 선택해주세요")
                    .applyCertiFont(.sub_bold_20)
                    .foregroundStyle(.grayscale600)
            }
            .frame(height: 26)
            .padding(.leading, 20)
            .padding(.bottom, 4)
            
            Text("추후 희망직무 재설정이 가능합니다.\n(2,3순위 선택 가능)")
                .applyCertiFont(.caption_regular_12)
                .foregroundStyle(.grayscale400)
                .frame(height: 36)
                .padding(.leading, 20)
                .padding(.bottom, 18)
            
            LazyVGrid(columns: columns, spacing: 14) {
                ForEach(jobOptions, id: \.self) { job in
                    Button {
                        if selectedJob == job {
                            selectedJob = ""
                        } else if viewModel.selectedJobCategory.count < 3 {
                            selectedJob = job
                        }
                    } label: {
                        Text(job)
                            .applyCertiFont(viewModel.selectedJobCategory.contains(job) ? .body_semibold_16 : .body_regular_16)
                            .foregroundColor(viewModel.selectedJobCategory.contains(job) ? .grayscale300 :
                                                selectedJob == job ? .mainblue : .grayscale500)
                            .frame(maxWidth: .infinity, minHeight: 56)
                            .background(viewModel.selectedJobCategory.contains(job) ? .grayscale100 :
                                            selectedJob == job ? .lightblue : .bluewhite)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(viewModel.selectedJobCategory.contains(job) ? .grayscale200 : selectedJob == job ? .skyblue : .lightblue , lineWidth: 1)
                            }
                    }
                    .disabled(viewModel.selectedJobCategory.contains(job))
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 22)
            
            Spacer()
            
            if step == 1 {
                Button {
                    viewModel.selectedJobCategory.append(selectedJob)
                    selectedJob = ""
                    step += 1
                } label: {
                    Text("다음")
                        .applyCertiFont(.body_semibold_16)
                        .foregroundColor(selectedJob.isEmpty ? .grayscale400 : .white)
                        .frame(maxWidth: .infinity, minHeight: 56)
                        .background(selectedJob.isEmpty ? .grayscale100 : .purpleblue)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .disabled(selectedJob.isEmpty)
                .padding(.horizontal, 20)
                .padding(.bottom, 22)
            } else {
                HStack(alignment: .center, spacing: 17) {
                    Button {
                        selectedJob = ""
                        viewModel.navigateToInfo()
                    } label: {
                        Text("건너뛰기")
                            .applyCertiFont(.body_semibold_16)
                            .foregroundColor(.grayscale500)
                            .frame(maxWidth: .infinity, minHeight: 56)
                            .background(.grayscale100)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    
                    Button {
                        if step == 3 {
                            viewModel.selectedJobCategory.append(selectedJob)
                            selectedJob = ""
                            viewModel.navigateToInfo()
                        } else {
                            viewModel.selectedJobCategory.append(selectedJob)
                            selectedJob = ""
                            step += 1
                        }
                    } label: {
                        Text("다음")
                            .applyCertiFont(.body_semibold_16)
                            .foregroundColor(selectedJob.isEmpty ? .grayscale400 : .white)
                            .frame(maxWidth: .infinity, minHeight: 56)
                            .background(selectedJob.isEmpty ? .grayscale100 : .purpleblue)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .disabled(selectedJob.isEmpty)
                    
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 22)
            }
            
        }
    }
}
