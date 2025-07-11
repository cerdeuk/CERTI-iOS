//
//  OnboardingJobCategoryView.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/12/25.
//

import SwiftUI

struct OnboardingJobCategoryView: View {
    @EnvironmentObject private var onboardingCoordinator: OnboardingCoordinator
    @Binding var selectedJobCategory: [String]

    private let jobOptions = ["경영/사무", "마케팅/광고/홍보", "무역/유통", "IT/인터넷", "생산/제조", "영업/고객상담", "건설", "금융", "연구개발/설계", "디자인", "미디어", "전문/특수직"]
    
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            BackButton {
                onboardingCoordinator.pop()
            }
            .padding(.bottom, 13)
            
            Image(.onboardingProgressbar5)
                .padding(.leading, 20)
                .padding(.bottom, 40)
            
            Text("희망직무를 선택해주세요")
                .applyCertiFont(.sub_bold_20)
                .foregroundStyle(.grayscale600)
                .frame(height: 26)
                .padding(.leading, 20)
                .padding(.bottom, 4)
            
            Text("추후 희망직무 재설정이 가능합니다.\n(최대 3개 선택 가능)")
                .applyCertiFont(.caption_regular_12)
                .foregroundStyle(.grayscale400)
                .frame(height: 36)
                .padding(.leading, 20)
                .padding(.bottom, 18)
            
            LazyVGrid(columns: columns, spacing: 14) {
                ForEach(jobOptions, id: \.self) { job in
                    Button {
                        if selectedJobCategory.contains(job) {
                            selectedJobCategory.removeAll(where: { $0 == job })
                        } else if selectedJobCategory.count < 3 {
                            selectedJobCategory.append(job)
                        }
                    } label: {
                        Text(job)
                            .applyCertiFont(selectedJobCategory.contains(job) ? .body_semibold_16 : .body_regular_16)
                            .foregroundColor(selectedJobCategory.contains(job) ? .grayscale600 : .grayscale500)
                            .frame(maxWidth: .infinity, minHeight: 56)
                            .background(selectedJobCategory.contains(job) ? .lightblue : .bluewhite)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(selectedJobCategory.contains(job) ? .skyblue : .lightblue , lineWidth: 1)
                            }
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 22)
            
            Spacer()
            
            Button {
                onboardingCoordinator.push(next: .info)
            } label: {
                Text("다음")
                    .applyCertiFont(.body_semibold_16)
                    .foregroundColor(selectedJobCategory.isEmpty ? .grayscale400 : .white)
                    .frame(maxWidth: .infinity, minHeight: 56)
                    .background(selectedJobCategory.isEmpty ? .grayscale100 : .purpleblue)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .disabled(selectedJobCategory.isEmpty)
            .padding(.horizontal, 20)
            .padding(.bottom, 22)
        }
    }
}
