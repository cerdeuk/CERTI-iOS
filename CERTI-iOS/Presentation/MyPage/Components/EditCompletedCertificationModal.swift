//
//  EditCompletedCertificationModal.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/12/26.
//

import SwiftUI

struct EditCompletedCertificationModal: View {
    
    // MARK: - Property Wrappers
    
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: MyPageViewModel
    
    @State private var selectedDate: Date? = Date()
    @State private var gradeInput: String = ""
    
    // MARK: - Properties
    
    let item: CompletedItem
    
    // MARK: - Init
    
    init(viewModel: MyPageViewModel, item: CompletedItem) {
        self.viewModel = viewModel
        self.item = item
        
        _gradeInput = State(initialValue: item.grade ?? "")
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let date = formatter.date(from: item.formattedDate) {
            _selectedDate = State(initialValue: date)
        } else {
            formatter.dateFormat = "yyyy. MM. dd"
            let date = formatter.date(from: item.formattedDate) ?? Date()
            _selectedDate = State(initialValue: date)
        }
    }
    
    //MARK: - Main Body

    var body: some View {
        VStack(spacing: 0) {
            ScrollView(.vertical) {
                headerView
                dateView
                scoreView
            }
            .scrollIndicators(.hidden)
            
            Spacer()
            
            bottomButtonView
        }
    }
}


// MARK: - SubViews

private extension EditCompletedCertificationModal {
    var headerView: some View {
        HStack(alignment: .center , spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                Text("자격증 취득 정보를 수정해주세요")
                    .applyCertiFont(.body_bold_18)
                    .foregroundStyle(.grayscale600)
                    .frame(height: 25)
                
                Text(item.name)
                    .applyCertiFont(.caption_semibold_14)
                    .foregroundStyle(.grayscale400)
                    .frame(height: 20)
            }
            .padding(.top, 60)
            .padding(.leading, 20)
            
            Spacer()
        }
    }
    
    var dateView: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                Image(.iconCheck24)
                
                Text("취득 날짜")
                    .applyCertiFont(.body_semibold_16)
                    .foregroundStyle(.grayscale600)
                    .frame(height: 22)
            }
            .padding(.leading, 20)
            
            DatePickerBox(selectedDate: $selectedDate)
                .padding(.top, 12)
        }
        .padding(.top, 32)
    }
    
    var scoreView: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                Image(.iconCheck24)
                
                Text("취득 점수 (선택)")
                    .applyCertiFont(.body_semibold_16)
                    .foregroundStyle(.grayscale600)
                    .frame(height: 22)
            }
            .padding(.leading, 20)
            
            TextField("점수 입력", text: $gradeInput)
                .padding(.horizontal, 16)
                .frame(height: 48)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.grayscale200, lineWidth: 1)
                )
                .padding(.horizontal, 20)
                .padding(.top, 12)
        }
        .padding(.top, 25)
    }
    
    var bottomButtonView: some View {
        VStack(alignment: .center, spacing: 0) {
            Button {
                saveChanges()
                dismiss()
            } label: {
                ZStack {
                    Rectangle()
                        .frame(width: 335, height: 56)
                        .foregroundStyle(.purpleblue)
                        .cornerRadius(12)
                    
                    Text("수정 완료")
                        .applyCertiFont(.body_semibold_16)
                        .foregroundStyle(.white)
                }
            }
            .padding(.top, 12)
            .padding(.bottom, 20)
        }
    }
}


// MARK: - Private Func

private extension EditCompletedCertificationModal {
    func saveChanges() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        print("========== [취득 완료 수정 확인] ==========")
        print("📝 자격증 이름: \(item.name)")
        print("📅 취득 날짜: \(formatter.string(from: selectedDate!))")
        print("💯 점수/등급: \(gradeInput.isEmpty ? "없음" : gradeInput)")
        print("=======================================")
    }
}
