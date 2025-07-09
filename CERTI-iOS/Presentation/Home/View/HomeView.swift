//
//  HomeView.swift
//  CERTI-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var homeCoordinator: HomeCoordinator
    
    let username = "김서티22"
    let userUniversity = "솝트대학교"
    let userDepartment = "서티취득학과"
    let progressValue: Int = 30
    
    let recommendLicenseDummy: [RecommendLicenseCardModel] = RecommendLicenseCardModel.dummy()
    
    let columns = [GridItem(.fixed(335))]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            certiLogo
            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: 0) {
                    profileSection
                    progressSection
                    recommendLicenseSection
                    
                    HStack(alignment: .center, spacing: 0) {
                        Text("취득 예정 자격증")
                            .frame(height: 26)
                        
                        Spacer()
                        
                        Button {
                            // 취득 예정 자격증 항목 이동
                        } label: {
                            Image(.iconArrowright36)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 36, height: 36)
                        }
                    }
                    .frame(height: 36)
                    .foregroundStyle(.grayscale600)
                    .applyCertiFont(.sub_semibold_20)
                    .padding(.bottom, 16)
                    
                    
                }
            }
            .scrollIndicators(.hidden)
        }
        .padding(.horizontal, 20)
        
    }
}

extension HomeView {
    private var certiLogo: some View {
        HStack(alignment: .center, spacing: 0) {
            Image(.imageLogoBlack)
                .resizable()
                .scaledToFit()
                .frame(width: 75, height: 25)
            Spacer()
        }
        .frame(height: 49)
    }
    
    private var profileSection: some View {
        Group {
            HStack(alignment: .center, spacing: 0) {
                Text("안녕하세요, ")
                Text.trimmedUsername(username)
                Text("님!")
            }
            .frame(height: 26)
            .applyCertiFont(.sub_bold_20)
            .foregroundStyle(.grayscale600)
            .padding(.bottom, 24)
            .padding(.top, 32)
            
            HStack(alignment: .center, spacing: 0) {
                Image(.imageProfileP)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .padding(.trailing, 12)
                
                Text.trimmedUsername(username)
                    .frame(height: 22)
                    .padding(.trailing, 8)
                
                HStack{}
                    .frame(width: 2, height: 42)
                    .background(.grayscale100)
                    .padding(.trailing, 8)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(userUniversity)
                        .frame(height: 22)
                        .padding(.bottom, 4)
                    Text(userDepartment)
                        .frame(height: 22)
                }
            }
            .applyCertiFont(.body_semibold_16)
            .foregroundStyle(.grayscale600)
            .padding(.bottom, 12)
        }
    }
    
    private var progressSection: some View {
        Group {
            ProgressView(value: Double(progressValue) / 100.0)
                .frame(height: 12)
                .scaleEffect(x: 1, y: 1.3)
                .tint(.purpleblue)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.bottom, 8)
            
            if progressValue == 0 {
                Text("회원님의 이력서를 채워보세요!")
                    .applyCertiFont(.caption_regular_14)
                    .foregroundStyle(.grayscale600)
                    .frame(height: 20)
                    .padding(.bottom, 36)
            } else {
                HStack(alignment: .center, spacing: 0) {
                    Group {
                        Text("회원님의 이력서가 ")
                            .applyCertiFont(.caption_regular_14)
                            .foregroundStyle(.grayscale600)
                        Text("\(progressValue)% ")
                            .applyCertiFont(.caption_semibold_14)
                            .foregroundStyle(.mainblue)
                        Text("채워졌어요!")
                            .applyCertiFont(.caption_regular_14)
                            .foregroundStyle(.grayscale600)
                    }
                    .frame(height: 20)
                    .padding(.bottom, 36)
                }
            }
        }
    }
    
    private var recommendLicenseSection: some View {
        Group {
            HStack(alignment: .center, spacing: 0) {
                Text.trimmedUsername(username)
                    .frame(height: 26)
                
                Text("님에게 추천하는 자격증")
                    .frame(height: 26)
                
                Spacer()
                
                Button {
                    // 추천 자격증 항목 이동
                } label: {
                    Image(.iconArrowright36)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 36, height: 36)
                }
            }
            .frame(height: 36)
            .foregroundStyle(.grayscale600)
            .applyCertiFont(.sub_semibold_20)
            .padding(.bottom, 16)
            
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(recommendLicenseDummy) { dummy in
                    RecommendLicenseCard(licenseCard: dummy)
                }
            }
            .padding(.bottom, 36)
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(HomeCoordinator())
}
