//
//  CertificationDetailPlanModalView.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 11/16/25.
//

import SwiftUI

struct CertificationDetailPlanModalView: View {
    @ObservedObject var viewModel: CertificateDetailViewModel
    
    @Binding var certificationId: Int
    @Binding var isShowingSheet: Bool
    
    let certificationName: String
    
    var body: some View {
        ScrollView(.vertical) {
            headerView
            dateView
            placeView
            timeView
        }
        .scrollIndicators(.hidden)
        .onDisappear {
            viewModel.clearPreCertificationModel()
        }
        
        Spacer()
        
        bottomButtonView
    }
}

extension CertificationDetailPlanModalView {
    @ViewBuilder
    private var headerView: some View {
        HStack(alignment: .center , spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                Text("자격증 시험 정보를 입력해주세요")
                    .applyCertiFont(.body_bold_18)
                    .foregroundStyle(.grayscale600)
                    .frame(height: 25)
                
                Text(certificationName)
                    .applyCertiFont(.caption_semibold_14)
                    .foregroundStyle(.grayscale400)
                    .frame(height: 20)
            }
            .padding(.top, 60)
            .padding(.leading, 20)
            
            Spacer()
        }
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
            
            DatePickerBox(selectedDate: $viewModel.CertificationPlanDate)
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
                DropdownMenu(
                    selectedPlace: $viewModel.addPreCertificationModel.city,
                    options: viewModel.placeMenuOptions,
                    menuPlaceholder: "시/도"
                )
                .onChange(of: viewModel.addPreCertificationModel.city) { _ in
                    viewModel.addPreCertificationModel.state = nil
                }
                
                Spacer()
                
                DropdownMenu(selectedPlace: $viewModel.addPreCertificationModel.state, options: viewModel.placeMenuOptions2, menuPlaceholder: "구/시", isEnabled: viewModel.addPreCertificationModel.city != nil)
            }
            .padding(.top, 12)
            .padding(.horizontal, 20)
            
        }
        .padding(.top, 25)
        .zIndex(2)
    }
    
    @ViewBuilder
    private var timeView: some View {
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
            
            CertiTimePicker(isAM: $viewModel.isAM, hour: $viewModel.hour, minute: $viewModel.minute)
        }
        .padding(.top, 25)
        .zIndex(1)
    }
    
    @ViewBuilder
    private var bottomButtonView: some View {
        VStack(alignment: .center, spacing: 0) {
            Button {
                Task {
                    viewModel.clearPreCertificationModel()
                    viewModel.addPreCertificationModel.certificationId = certificationId
                    await viewModel.appendPreCertification(request: viewModel.addPreCertificationModel)
                }
                
                isShowingSheet.toggle()
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
                Task {
                    viewModel.addPreCertificationModel.certificationId = certificationId
                    if let dateTimeString = viewModel.makePlannedDateTimeString() {
                        viewModel.addPreCertificationModel.testDate = dateTimeString
                    }
                    await viewModel.appendPreCertification(request: viewModel.addPreCertificationModel)
                }
                
                isShowingSheet.toggle()
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
