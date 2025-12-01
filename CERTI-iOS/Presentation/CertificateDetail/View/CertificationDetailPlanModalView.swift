//
//  CertificationDetailPlanModalView.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 11/16/25.
//

import SwiftUI

struct CertificationDetailPlanModalView: View {
    @ObservedObject var viewModel: CertificateDetailViewModel
    
    @EnvironmentObject var tabRouter: CertiTabCoordinator
    
    @State private var isCalendarVisible: Bool = false
    @State var isAM = true
    @State var hour = 1
    @State var minute = 0
    
    private var dateFormatter: DateFormatter {
          let formatter = DateFormatter()
          formatter.dateFormat = "yyyy.MM.dd"
          formatter.locale = Locale(identifier: "ko_KR")
          return formatter
      }
    
    let certificationName: String
    let placeMenuOptions = ["서울", "경기" ,"인천", "강원", "충남", "충북"]
    let placeMenuOptions2 = ["강북구", "마포구" ,"용산구", "성북구"]

    
    var body: some View {
        ScrollView(.vertical) {
            headerView
            dateView
            placeView
            timeView
        }
        .scrollIndicators(.hidden)
        //.background(.yellow)
        Spacer()
        bottomButtonView
    }
}

extension CertificationDetailPlanModalView {
    @ViewBuilder
    private var headerView: some View {
        VStack(alignment: .leading, spacing: 0) {

            Text("자격증 시험 정보를 입력해주세요")
                .applyCertiFont(.body_bold_18)
                .foregroundStyle(.grayscale600)
                .frame(width: 229, height: 25)
                .padding(.leading, 20)
                .padding(.trailing, 126)
            
            Text(certificationName)
                .applyCertiFont(.caption_semibold_14)
                .foregroundStyle(.grayscale400)
                .frame(width: 149, height: 20)
                .padding(.leading, 20)
                .padding(.trailing, 206)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    @ViewBuilder
    private var dateView: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                Image(.iconCheck24)
                    .frame(width: 24, height: 24)
                
                Text("시험 날짜")
                    .applyCertiFont(.body_semibold_16)
                    .foregroundStyle(.grayscale600)
                    .frame(height: 22)
            }
            .frame(width: 88, height: 24)
            .padding(.leading, 20)
            .padding(.trailing, 267)
            
            VStack(alignment: .leading, spacing: 0) {
                Button {
                    withAnimation(.easeInOut(duration: 0.2)){
                        isCalendarVisible.toggle()
                    }
                } label: {
                    HStack(alignment: .center, spacing: 0) {
                        if viewModel.CertificationPlanDate != nil {
                            Text(dateFormatter.string(from: viewModel.CertificationPlanDate!))
                                .applyCertiFont(.caption_regular_14)
                                .foregroundStyle(.black)
                        } else {
                            Text("시험 날짜를 선택해주세요.")
                                .applyCertiFont(.caption_semibold_12)
                                .foregroundStyle(.grayscale300)
                        }
                        
                        Spacer()
                        
                        Image(.iconArrowdown24)
                            .foregroundStyle(.grayscale400)
                    }
                    .padding(.vertical, 11)
                    .padding(.leading, 12)
                    .padding(.trailing, 8)
                }
                .frame(height: 40)
                .background(.clear)
                .clipShape(RoundedRectangle(cornerRadius: 4))
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(.grayscale200, lineWidth: 1)
                )
                .padding(.horizontal, 20)
                
                if isCalendarVisible {
                    DatePicker("", selection: Binding<Date>(
                        get: { self.viewModel.CertificationPlanDate ?? Date() },
                        set: {
                            self.viewModel.CertificationPlanDate = $0
                            withAnimation {
                                self.isCalendarVisible = false
                            }
                        }
                    ), displayedComponents: .date)
                        .datePickerStyle(.graphical)
                        .environment(\.locale, Locale(identifier: "ko_KR"))
                        .background(Color.white)
                        .padding(.horizontal, 8)
                        .padding(.top, 11)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(color: .black.opacity(0.08), radius: 20, x: 4, y: 4)

                }
            }
            .padding(.top, 12)
        }
        .padding(.top, 32)
    }
    
    @ViewBuilder
    private var placeView: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                Image(.iconCheck24)
                    .frame(width: 24, height: 24)
                
                Text("시험 장소")
                    .applyCertiFont(.body_semibold_16)
                    .foregroundStyle(.grayscale600)
                    .frame(height: 22)
            }
            .frame(width: 88, height: 24)
            .padding(.leading, 20)
            .padding(.trailing, 267)
            
            HStack(alignment: .center, spacing: 0) {
                DropdownMenu(options: placeMenuOptions, menuPlaceholder: "시/도")
                
                Spacer()
                
                DropdownMenu(options: placeMenuOptions2, menuPlaceholder: "구/시")
            }
            .padding(.top, 12)
            .padding(.horizontal, 20)

        }
        .padding(.top, 25)
        .zIndex(2)
    }
    
    @ViewBuilder
    private var timeView: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                Image(.iconCheck24)
                    .frame(width: 24, height: 24)
                
                Text("시험 시간")
                    .applyCertiFont(.body_semibold_16)
                    .foregroundStyle(.grayscale600)
                    .frame(height: 22)
            }
            .frame(width: 88, height: 24)
            .padding(.leading, 20)
            .padding(.trailing, 267)
            
            CertiTimePicker(isAM: $isAM, hour: $hour, minute: $minute)
                .padding(.horizontal, 20)
        }
        .padding(.top, 25)
        .zIndex(1)
    }
    
    @ViewBuilder
    private var bottomButtonView: some View {
        VStack(alignment: .center, spacing: 0) {
            Button {
                print("나중에 입력하기 클릭")
            } label: {
                VStack(alignment: .center, spacing: 0) {
                    Text("나중에 입력하기")
                        .applyCertiFont(.caption_semibold_12)
                        .foregroundStyle(.grayscale300)
                    
                    Rectangle()
                        .frame(width: 97, height: 1)
                        .foregroundStyle(.grayscale200)
                        .padding(.top, 4)
                }
            }
            
            Button {
                print("적용하기 클릭")
            } label: {
                ZStack {
                    Rectangle()
                        .frame(width: 335, height: 56)
                        .foregroundStyle(.purpleblue)
                        .cornerRadius(12)
                    
                    Text("적용하기")
                        .applyCertiFont(.body_semibold_16)
                        .foregroundStyle(.white)
                }
            }
            .padding(.top, 12)
        }
    }
}

#Preview {
    CertificationDetailPlanModalView(viewModel: CertificateDetailViewModel(
        fetchCertificationDetailUseCase: PreviewFetchCertificationDetailUseCase(),
        addPreCertificationUseCase: PreviewAddPreCertificationUseCase(),
        addAcquisitionUseCase: PreviewAddAcquisitionUseCase()),
                                     certificationName: "GTQ 1급 (그래픽기술자격)")
}

