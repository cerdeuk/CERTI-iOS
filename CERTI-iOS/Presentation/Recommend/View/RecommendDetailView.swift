//
//  RecommendDetailView.swift
//  CERTI-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI

struct RecommendDetailView: View {
    @EnvironmentObject var recommendCoordinator: RecommendCoordinator
    @EnvironmentObject var tabRouter: CertiTabCoordinator
    let model: RecommendDetailModel = RecommendDetailModel.dummy()

    var body: some View {
       
        VStack(spacing: 0) {
            BackButton {
                recommendCoordinator.pop()
            }
            
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Text(model.certificationName)
                        .applyCertiFont(.sub_bold_20)
                        .foregroundStyle(.grayscale600)
                        .frame(height: 26)
                        .padding(.top, 33)
                        .padding(.horizontal, 20)
                    
                    TagChip(tags: model.tags, spacing: 8)
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
                    
                    Text(model.averagePeriod)
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
                    
                    Text("\((String(model.charge)).convertPrice(maxPrice: model.charge))원")
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
                    
                    Text(model.agency)
                        .applyCertiFont(.body_regular_16)
                        .foregroundStyle(.grayscale600)
                        .frame(height: 22)
                }
                .padding(.top, 40)
                .padding(.bottom, 11)
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
                Text(model.testType)
                    .applyCertiFont(.body_semibold_16)
                    .foregroundStyle(.grayscale600)
                    .frame(height: 22)
                    .padding(.top, 36)
                
                Text(model.description.antiAppleBySangyup)
                    .applyCertiFont(.caption_regular_14)
                    .padding(.all, 20)
                    .foregroundColor(.grayscale600)
                    .background(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.grayscale100, lineWidth: 1)
                        )
                    .padding(.top, 12)
                
                Text("시험일자")
                    .padding(.top, 24)
                
                HStack(spacing: 0) {
                    Image(.iconDate16)
                    
                    Text(model.testDateInformation)
                        .applyCertiFont(.body_regular_16)
                        .foregroundStyle(.grayscale600)
                        .frame(height: 22)
                        .padding(.leading, 6)
                    
                    Spacer()
                    
                }
                .padding(.top, 12)
                
                Text("신청방법")
                    .padding(.top, 24)
                
                HStack(spacing: 0) {
                    Image(.iconCertification16)
                    
                    Text(model.applicationMethod)
                        .applyCertiFont(.body_regular_16)
                        .foregroundStyle(.grayscale600)
                        .frame(height: 22)
                        .padding(.leading, 6)
                    
                    Spacer()

                }
                .padding(.top, 12)
                
                Text("자격증 유효기간")
                    .padding(.top, 24)
                
                HStack(spacing: 0) {
                    Image(.iconCertification16)
                    
                    Text(model.expirationPeriod)
                        .applyCertiFont(.body_regular_16)
                        .foregroundStyle(.grayscale600)
                        .frame(height: 22)
                        .padding(.leading, 6)
                    
                    Spacer()

                }
                .padding(.top, 12)
                
                Link(destination: URL(string: model.applicationUrl)!) {
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
        .background(.clear)
    }
    
    private var AcquiredButton: some View {
        Button {
            
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
        .background(.clear)
    }
}

#Preview {
    RecommendDetailView()
}
