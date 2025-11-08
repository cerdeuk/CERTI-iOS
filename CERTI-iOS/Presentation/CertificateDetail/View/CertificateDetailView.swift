//
//  CertificateDetailView.swift
//  CERTI-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI

struct CertificateDetailView: View {
    @ObservedObject var viewModel: CertificateDetailViewModel

    @Binding var certificationId: Int
    
    let onBack: () -> Void
    
    @State private var opacity: Double = 1.0
    
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                BackButton {
                    onBack()
                }
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(viewModel.certificateDetailModel.certificationName)
                            .applyCertiFont(.sub_bold_20)
                            .foregroundStyle(.grayscale600)
                            .frame(height: 26)
                            .padding(.top, 33)
                            .padding(.horizontal, 20)
                        
                        TagChip(tags: viewModel.certificateDetailModel.tags, spacing: 8)
                            .padding(.top, 12)
                            .padding(.horizontal, 20)
                        
                        CertificationBox
                        
                        Text("자격증 설명")
                            .applyCertiFont(.body_bold_18)
                            .foregroundStyle(.grayscale600)
                            .frame(height: 25)
                            .padding(.horizontal, 20)
                            .padding(.top, 48)
                        
                        CertificationDescription
                        
                        ToBeAcquiredButton
                            .padding(.top, 59)
                        
                        AcquiredButton
                    }
                }
                .scrollIndicators(.hidden)
            }
            .navigationBarBackButtonHidden(true)
            
            if viewModel.showSuccessToBeAcquired {
                CertificateDetailSuccessToastMessage(title: "취득 예정 자격증이 추가되었어요!", subtitle: "(홈-취득 예정 자격증에서 확인 가능)")
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeOut(duration: 2.0)) {
                            opacity = 1
                        }
                        Task {
                            try? await Task.sleep(nanoseconds: 1_000_000_000)
                            withAnimation(.easeOut(duration: 1.0)) {
                                opacity = 0
                            }
                            try? await Task.sleep(nanoseconds: 1_000_000_000)
                            viewModel.showSuccessToBeAcquired = false
                            opacity = 1
                        }
                    }
                    .padding(.horizontal, 37)
                    .padding(.bottom, 36)
            }
            
            if viewModel.showFailToBeAcquired {
                CertificateDetailFailToastMessage(title: "이미 추가된 자격증입니다.", subtitle: "홈-취득 예정 자격증에서 확인 가능")
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeOut(duration: 2.0)) {
                            opacity = 1
                        }
                        Task {
                            try? await Task.sleep(nanoseconds: 1_000_000_000)
                            withAnimation(.easeOut(duration: 1.0)) {
                                opacity = 0
                            }
                            try? await Task.sleep(nanoseconds: 1_000_000_000)
                            viewModel.showFailToBeAcquired = false
                            opacity = 1
                        }
                    }
                    .padding(.horizontal, 37)
                    .padding(.bottom, 36)
            }
            
            if viewModel.showFailAcquired {
                CertificateDetailFailToastMessage(title: "이미 취득 완료된 자격증입니다.", subtitle: "이력서 탭에서 확인 가능")
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeOut(duration: 2.0)) {
                            opacity = 1
                        }
                        Task {
                            try? await Task.sleep(nanoseconds: 1_000_000_000)
                            withAnimation(.easeOut(duration: 1.0)) {
                                opacity = 0
                            }
                            try? await Task.sleep(nanoseconds: 1_000_000_000)
                            viewModel.showFailAcquired = false
                            opacity = 1
                        }
                    }
                    .padding(.horizontal, 37)
                    .padding(.bottom, 36)
            }
            
            if viewModel.showCompleteModal {
                ZStack {
                    Color.blackOpacity40
                        .onTapGesture {
                            viewModel.showCompleteModal = false
                        }
                    CertificationDetailCompleteModalView(certificationName: viewModel.certificateDetailModel.certificationName)
                }
                .ignoresSafeArea()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .task {
            await viewModel.fetchCertificateDetail(certificationId: certificationId)
        }
    }
    
    private var CertificationBox : some View {
        VStack(spacing: 0) {
            Group {
                HStack(spacing: 0) {
                    Text("평균 취득 기간")
                        .applyCertiFont(.body_semibold_16)
                        .foregroundStyle(.grayscale600)
                        .frame(height: 22)
                    
                    Spacer()
                    
                    Text(viewModel.certificateDetailModel.averagePeriod)
                        .applyCertiFont(.body_regular_16)
                        .foregroundStyle(.grayscale600)
                        .frame(height: 22)
                }
                .padding(.top, 20)
                
                HStack(spacing: 0) {
                    Text("수수료")
                        .applyCertiFont(.body_semibold_16)
                        .foregroundStyle(.grayscale600)
                        .frame(height: 22)
                    
                    Spacer()
                    
                    Text(viewModel.certificateDetailModel.charge)
                        .applyCertiFont(.body_regular_16)
                        .foregroundStyle(.grayscale600)
                        .frame(height: 22)
                }
                .padding(.top, 40)
                
                HStack(spacing: 0) {
                    Text("기관명")
                        .applyCertiFont(.body_semibold_16)
                        .foregroundStyle(.grayscale600)
                        .frame(height: 22)
                    
                    Spacer()
                    
                    Text(viewModel.certificateDetailModel.agencyName)
                        .applyCertiFont(.body_regular_16)
                        .foregroundStyle(.grayscale600)
                        .frame(height: 22)
                }
                .padding(.top, 40)
                .padding(.bottom, 20)
            }
            .padding(.horizontal, 22)
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.bluewhite)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.lightblue, lineWidth: 1)
                )
        )
        .padding(.top, 36)
        .padding(.horizontal, 20)
    }
    
    private var CertificationDescription : some View {
        VStack(alignment: .leading, spacing: 0) {
            Group {
                Text(viewModel.certificateDetailModel.testType)
                    .applyCertiFont(.body_semibold_16)
                    .foregroundStyle(.grayscale600)
                    .frame(height: 22)
                    .padding(.top, 36)
                
                Text(viewModel.certificateDetailModel.description.antiAppleBySangyup)
                    .applyCertiFont(.caption_regular_14)
                    .padding(.all, 20)
                    .foregroundColor(.grayscale600)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.grayscale100, lineWidth: 1)
                    )
                    .padding(.top, 12)
                
                Text("시험일자")
                    .applyCertiFont(.body_semibold_16)
                    .foregroundStyle(.grayscale600)
                    .frame(height: 22)
                    .padding(.top, 24)
                
                
                HStack(spacing: 0) {
                    Image(.iconDate16)
                    
                    Text(viewModel.certificateDetailModel.testDateInformation)
                        .applyCertiFont(.body_regular_16)
                        .foregroundStyle(.grayscale600)
                        .frame(height: 22)
                        .padding(.leading, 6)
                    
                    Spacer()
                    
                }
                .padding(.top, 12)
                
                Text("신청방법")
                    .applyCertiFont(.body_semibold_16)
                    .foregroundStyle(.grayscale600)
                    .frame(height: 22)
                    .padding(.top, 24)
                
                HStack(spacing: 0) {
                    Image(.iconCertification16)
                    
                    Text(viewModel.certificateDetailModel.applicationMethod)
                        .applyCertiFont(.body_regular_16)
                        .foregroundStyle(.grayscale600)
                        .frame(height: 22)
                        .padding(.leading, 6)
                    
                    Spacer()
                    
                }
                .padding(.top, 12)
                
                Text("자격증 유효기간")
                    .applyCertiFont(.body_semibold_16)
                    .foregroundStyle(.grayscale600)
                    .frame(height: 22)
                    .padding(.top, 24)
                
                HStack(spacing: 0) {
                    Image(.iconClock16)
                    
                    Text(viewModel.certificateDetailModel.expirationPeriod)
                        .applyCertiFont(.body_regular_16)
                        .foregroundStyle(.grayscale600)
                        .frame(height: 22)
                        .padding(.leading, 6)
                    
                    Spacer()
                    
                }
                .padding(.top, 12)
                
                Link(destination: URL(string: viewModel.certificateDetailModel.applicationUrl)!) {
                    HStack(spacing: 0) {
                        Image(.iconLink16)
                        Text("사이트로 이동하기")
                            .applyCertiFont(.caption_semibold_12)
                            .foregroundStyle(.purpleblue)
                            .frame(height: 18)
                            .padding(.leading, 4)
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 26)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.purplewhite)
                    )
                }
                .padding(.top, 24)
            }
            .padding(.horizontal, 20)
        }
    }
    
    private var ToBeAcquiredButton: some View {
        Button {
            Task {
                await viewModel.appendPreCertification(certificationId: certificationId)
            }
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(.bluewhite)
                    .frame(height: 48)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.lightblue, lineWidth: 1)
                    )
                
                Text("취득 예정")
                    .applyCertiFont(.body_semibold_16)
                    .foregroundStyle(.purpleblue)
                    .frame(height: 22)
            }
            .padding(.horizontal, 20)
        }
        .padding(.bottom, 12)
    }
    
    private var AcquiredButton: some View {
        Button {
            Task {
                await viewModel.appendAcquisition(certificationId: certificationId)
            }
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(.purpleblue)
                    .frame(height: 48)
                
                Text("취득 완료")
                    .applyCertiFont(.body_semibold_16)
                    .foregroundStyle(.white)
                    .frame(height: 22)
            }
            .padding(.horizontal, 20)
        }
        .padding(.bottom, 12)
    }
}
