//
//  JobCategoryFilterModal.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/12/26.
//

import SwiftUI

struct JobCategoryFilterModal: View {
    
    // MARK: - Property Wrappers
    
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: MyPageViewModel
    
    @State private var tempSelectedJobs: [JobCategory] = []
    
    // MARK: - Init
    
    init(viewModel: MyPageViewModel) {
        self.viewModel = viewModel
        _tempSelectedJobs = State(initialValue: viewModel.jobCategoryList)
    }
    
    // MARK: - Main Body
    
    var body: some View {
        VStack(spacing: 0) {
            header
            
            jobCategoryGrid
            
            Spacer()
            
            applyButton
        }
        .padding(.bottom, 36)
    }
}


// MARK: - SubViews

private extension JobCategoryFilterModal {
    
    var header: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("필터")
                .applyCertiFont(.sub_bold_20)
                .foregroundStyle(.grayscale600)
                .frame(height: 24)
                .padding(.top, 73)
            
            Text("희망직무/분야 재설정하기")
                .applyCertiFont(.caption_semibold_14)
                .foregroundStyle(.mainblue)
                .frame(height: 20)
                .padding(.top, 12)
            
            Text("차례대로 1~3지망을 선택할 수 있습니다. (최대 3개)")
                .applyCertiFont(.caption_regular_12)
                .foregroundStyle(.grayscale500)
                .frame(height: 18)
                .padding(.top, 3)
            
            Rectangle()
                .fill(Color.grayscale200)
                .frame(height: 1)
                .padding(.top, 10)
        }
        .padding(.horizontal, 20)
    }
    
    var jobCategoryGrid: some View {
        LazyVGrid(columns: Array(repeating: .init(spacing: 16), count: 3), spacing: 13) {
            ForEach(JobCategory.allCases, id: \.self) { category in
                JobCategoryFilterButton(
                    category: category,
                    isSelected: tempSelectedJobs.contains(category),
                    selectedIndex: getSelectedIndex(category)
                ) {
                    toggleSelection(category)
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 36)
    }
    
    var applyButton: some View {
        Button {
            saveChanges()
            dismiss()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(tempSelectedJobs.isEmpty ? .grayscale100 : .purpleblue)
                    .frame(height: 56)
                
                Text("적용하기")
                    .applyCertiFont(.body_semibold_16)
                    .foregroundStyle(tempSelectedJobs.isEmpty ? .grayscale400 : .white)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
        .disabled(tempSelectedJobs.isEmpty)
    }
}


// MARK: - Private Func

private extension JobCategoryFilterModal {
    
    func getSelectedIndex(_ category: JobCategory) -> Int? {
        if let index = tempSelectedJobs.firstIndex(of: category) {
            return index + 1
        }
        return nil
    }
    
    func toggleSelection(_ category: JobCategory) {
        if let index = tempSelectedJobs.firstIndex(of: category) {
            tempSelectedJobs.remove(at: index)
        } else {
            if tempSelectedJobs.count < 3 {
                tempSelectedJobs.append(category)
            }
        }
    }
    
    func saveChanges() {
        viewModel.updateJobCategories(tempSelectedJobs)
    }
}
