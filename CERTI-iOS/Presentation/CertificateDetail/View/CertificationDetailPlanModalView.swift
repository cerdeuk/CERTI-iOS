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
    
    private var dateFormatter: DateFormatter {
          let formatter = DateFormatter()
          formatter.dateFormat = "yyyy.MM.dd"
          formatter.locale = Locale(identifier: "ko_KR")
          return formatter
      }
    
    let certificationName: String
    
    var body: some View {
        ScrollView(.vertical) {
            headerView
            dateView
            placeView
            timeView
        }
        .scrollIndicators(.hidden)
        //.background(.yellow)
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
                                .applyCertiFont(.caption_semibold_14)
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
                .background(.grayscale0)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
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
        }
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

