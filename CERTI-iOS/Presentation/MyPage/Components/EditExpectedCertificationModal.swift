//
//  EditExpectedCertificationModal.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/12/26.
//

import SwiftUI

struct EditExpectedCertificationModal: View {
    
    //MARK: - Property Wrappers
    
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: MyPageViewModel
    
    @State private var selectedDate: Date? = Date()
    @State private var selectedProvince: String? = ""
    @State private var selectedCity: String? = ""
    
    @State private var isAM: Bool = true
    @State private var hour: Int = 12
    @State private var minute: Int = 0
    
    //MARK: - Properties
    
    let item: ExpectedItem
    
    let placeMenuOptions = ["서울", "경기" ,"인천", "강원", "충남", "충북"]
    let placeMenuOptions2 = ["강북구", "마포구" ,"용산구", "성북구", "일산동구", "강남구"]
    
    //MARK: - init
    
    init(viewModel: MyPageViewModel, item: ExpectedItem) {
        self.viewModel = viewModel
        self.item = item
        
        _selectedProvince = State(initialValue: item.city)
        _selectedCity = State(initialValue: item.state)
        
        let timeParts = item.formattedTime.split(separator: ":").map { Int($0) ?? 0 }
        var initialIsAM = true
        var initialHour = 12
        var initialMinute = 0
        
        if timeParts.count >= 2 {
            let rawHour = timeParts[0]
            initialMinute = timeParts[1]
            
            if rawHour < 12 {
                initialIsAM = true
                initialHour = rawHour == 0 ? 12 : rawHour
            } else {
                initialIsAM = false
                initialHour = rawHour == 12 ? 12 : rawHour - 12
            }
        }
        
        _isAM = State(initialValue: initialIsAM)
        _hour = State(initialValue: initialHour)
        _minute = State(initialValue: initialMinute)
        
        let date = Date() // TODO: - 임시로 현재 날짜, API 연결하면서 수정
        _selectedDate = State(initialValue: date)
    }
    
    //MARK: - Main Body
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(.vertical) {
                headerView
                dateView
                placeView
                timeView
            }
            .scrollIndicators(.hidden)
            
            Spacer()
            
            bottomButtonView
        }
    }
}


// MARK: - SubViews

private extension EditExpectedCertificationModal {
    var headerView: some View {
        HStack(alignment: .center , spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                Text("자격증 시험 정보를 수정해주세요")
                    .applyCertiFont(.body_bold_18)
                    .foregroundStyle(.grayscale600)
                    .frame(height: 25)
                
                Text(item.certificationName)
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
                    .frame(width: 24, height: 24)
                
                Text("시험 날짜")
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
    
    var placeView: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                Image(.iconCheck24)
                    .frame(width: 24, height: 24)
                
                Text("시험 장소")
                    .applyCertiFont(.body_semibold_16)
                    .foregroundStyle(.grayscale600)
                    .frame(height: 22)
            }
            .padding(.leading, 20)
            
            HStack(alignment: .center, spacing: 0) {
                DropdownMenu(selectedPlace: $selectedProvince, options: placeMenuOptions, menuPlaceholder: "시/도")
                
                Spacer()
                
                DropdownMenu(selectedPlace: $selectedCity, options: placeMenuOptions2, menuPlaceholder: "구/시")
            }
            .padding(.top, 12)
            .padding(.horizontal, 20)
        }
        .padding(.top, 25)
        .zIndex(2)
    }
    
    var timeView: some View {
        VStack(alignment: .center, spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                Image(.iconCheck24)
                    .frame(width: 24, height: 24)
                
                Text("시험 시간")
                    .applyCertiFont(.body_semibold_16)
                    .foregroundStyle(.grayscale600)
                    .frame(height: 22)
                
                Spacer()
            }
            .frame(height: 24)
            .padding(.leading, 20)
            
            CertiTimePicker(isAM: $isAM, hour: $hour, minute: $minute)
        }
        .padding(.top, 25)
        .zIndex(1)
    }
    
    var bottomButtonView: some View {
        VStack(alignment: .center, spacing: 0) {
            Button {
                Task {
                    await viewModel.editExpectedCertificate(
                        id: item.preCertificationId,
                        date: selectedDate ?? Date(),
                        isAM: isAM,
                        hour: hour,
                        minute: minute,
                        province: selectedProvince ?? "",
                        city: selectedCity ?? ""
                    )
                }
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
