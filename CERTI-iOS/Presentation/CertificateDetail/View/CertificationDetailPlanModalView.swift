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
    
    @Binding var certificationId: Int
    @Binding var isShowingSheet: Bool
    
    let certificationName: String
    
    // TODO: - API 연결하면 지우기
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
        .padding(.top, 60)
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
                DropdownMenu(selectedPlace: $viewModel.CertificationPlanPlaceDo, options: placeMenuOptions, menuPlaceholder: "시/도")
                
                Spacer()
                
                DropdownMenu(selectedPlace: $viewModel.CertificationPlanPlaceSi, options: placeMenuOptions2, menuPlaceholder: "구/시")
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
                // TODO: - API 연결하기
                //                Task {
                //                    await viewModel.appendPreCertification(certificationId: certificationId)
                //                }
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
                // TODO: - API 연결하기
                //                Task {
                //                    await viewModel.appendPreCertification(certificationId: certificationId)
                //                }
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

#Preview {
    struct PreviewWrapper: View {
        @State var certificationId = 1
        @State var isShowingSheet = true
        
        var body: some View {
            CertificationDetailPlanModalView(viewModel: CertificateDetailViewModel(
                fetchCertificationDetailUseCase: PreviewFetchCertificationDetailUseCase(),
                addPreCertificationUseCase: PreviewAddPreCertificationUseCase(),
                addAcquisitionUseCase: PreviewAddAcquisitionUseCase()),
                                             certificationId: $certificationId, isShowingSheet: $isShowingSheet, certificationName: "GTQ 1급 (그래픽기술자격)")
        }
    }
    return PreviewWrapper()
}

