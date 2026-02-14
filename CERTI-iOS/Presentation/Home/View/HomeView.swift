//
//  HomeView.swift
//  CERTI-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    let columns = [GridItem(.flexible())]
    let rows = [GridItem(.fixed(200))]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            certiLogo
                .padding(.horizontal, 20)

            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: 0) {
                    profileSection
                        .padding(.horizontal, 20)

                    HomeCalendarView(viewModel: viewModel)
                    
                    // 값이 없으면 나타내는 뷰
                    if viewModel.homeStateModel.calendarPreLicenseCardModel.isEmpty {
                        preLicenseEmptyView
                    } else {
                        scheduleListView
                            .padding(.top, 16)
                            .padding(.bottom, 36)
                    }
                    
                    favoriteLicenseTitle
                        .padding(.horizontal, 20)

                    // 값이 없으면 나타내는 뷰
                    if viewModel.homeStateModel.favoriteLicenses.isEmpty {
                        favoriteLicenseEmptyView
                    } else {
                        favoriteLicenseList
                    }
                    
                    recommendLicenseTitle
                        .padding(.horizontal, 20)

                    recommendLicenseList
                        .padding(.horizontal, 20)
                }
            }
            .scrollIndicators(.hidden)
        }
        .onAppear {
            Task {
                async let userInfo: () = viewModel.getUserInfo()
                async let recommendList: () = viewModel.getRecommendCertificationList()
                async let favoriteList: () = viewModel.getFavoriteCertificationList()

                _ = await (userInfo, recommendList, favoriteList)
            }
        }
    }
}

extension HomeView {
    private var certiLogo: some View {
        HStack(alignment: .center, spacing: 0) {
            Image(.imageLogoBlack)
                .resizable()
                .scaledToFit()
                .frame(width: 75, height: 25)
                .onTapGesture {
                    //TODO: - 탈퇴하기 뷰 생기면 지우기
                    Task {
                        await viewModel.withDraw()
                        viewModel.withDrawNavigate()
                    }
                }
            
            Spacer()
        }
        .frame(height: 49)
    }
    
    private var profileSection: some View {
        Group {
            HStack(alignment: .center, spacing: 0) {
                Image(.imageProfilePdf)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .padding(.trailing, 12)
                
                Text(viewModel.homeStateModel.username.trimmedUsername())
                    .frame(height: 22)
                    .padding(.trailing, 8)
                
                Color.grayscale100
                    .frame(width: 2, height: 42)
                    .padding(.trailing, 8)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(viewModel.homeStateModel.userUniversity)
                        .frame(height: 22)
                        .padding(.bottom, 4)
                    Text(viewModel.homeStateModel.userDepartment)
                        .frame(height: 22)
                }
            }
            .applyCertiFont(.body_semibold_16)
            .foregroundStyle(.grayscale600)
            .padding(.top, 20)
            .padding(.bottom, 36)
        }
    }
    
    private var scheduleListView: some View {
        VStack(alignment: .center, spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                Text(viewModel.selectedDateKoreanString)
                    .applyCertiFont(.body_semibold_16)
                    .frame(height: 22)
                
                Spacer()
            }
            .padding(.top, 16)
            .padding(.bottom, 16)
            
            ForEach(viewModel.homeStateModel.calendarPreLicenseCardModel, id: \.certificationId) { cert in
                MyCertificationItem(
                    type: .expected(
                        location: cert.location,
                        time: cert.time.toHHmm()
                    ),
                    title: cert.title,
                    category: cert.category,
                    description: cert.description,
                    actionConfig: .viewOnly
                )
                .onTapGesture {
                    viewModel.selectedLicenseId = cert.certificationId
                    viewModel.navigateToCertificateDetail()
                }
            }
            .padding(.bottom, 16)
        }
        .padding(.horizontal, 20)
        .background(.purplewhite)
    }
    
    private var preLicenseEmptyView: some View {
        VStack(alignment: .center, spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                Text(viewModel.selectedDateKoreanString)
                    .applyCertiFont(.body_semibold_16)
                    .frame(height: 22)
                
                Spacer()
            }
            .padding(.horizontal, 20)
            
            Text("예정된 일정이 없습니다.\n자격증 탭에서 취득 예정 자격증을 추가해보세요.")
                .applyCertiFont(.caption_regular_14)
                .foregroundStyle(.grayscale400)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 36)

            HStack(alignment: .center, spacing: 0) {
                Spacer()
                
                Button {
                    viewModel.navigateToCertificateTab()
                } label: {
                    Image(.iconCirclePlusFill)
                }

                Spacer()
            }
            .padding(.top, 12)
        }
        .padding(.top, 16)
        .padding(.bottom, 36)
    }
    
    private var favoriteLicenseTitle: some View {
        HStack(alignment: .center, spacing: 0) {
            Text("즐겨찾기한 자격증")
                .frame(height: 26)
            
            Spacer()

        }
        .frame(height: 36)
        .foregroundStyle(.grayscale600)
        .applyCertiFont(.sub_semibold_20)
        .padding(.bottom, 16)
    }
    
    private var favoriteLicenseList: some View {
        ScrollView(.horizontal){
            LazyHGrid(rows: rows, spacing: 12) {
                ForEach(viewModel.homeStateModel.favoriteLicenses) { item in
                    FavoriteLicenseCard(viewModel: viewModel, licenseCard: item)
                        .onTapGesture {
                            viewModel.selectedLicenseId = item.id
                            viewModel.navigateToCertificateDetail()
                        }
                }
            }
            .padding(.horizontal, 20)
        }
        .frame(height: 160)
        .padding(.bottom, 36)
        .scrollIndicators(.hidden)
    }
    
    private var favoriteLicenseEmptyView: some View {
        VStack(alignment: .center, spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                Spacer()
                Image(.imageEmpty)
                Spacer()
            }
            .padding(.bottom, 20)
            
            Text("즐겨찾기한 자격증이 없습니다.")
                .applyCertiFont(.caption_regular_14)
                .foregroundStyle(.grayscale400)
                .frame(height: 20)
        }
        .padding(.top, 20)
        .padding(.bottom, 36)
    }
    
    private var recommendLicenseTitle: some View {
        HStack(alignment: .center, spacing: 0) {
            Text(viewModel.homeStateModel.username.trimmedUsername())
                .frame(height: 26)
            
            Text("님에게 추천하는 자격증")
                .frame(height: 26)
            
            Spacer()
            
            Button {
                viewModel.navigateToCertificateTab()
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
    
    private var recommendLicenseList: some View {
        VStack(alignment: .center, spacing: 0){
            ForEach(viewModel.homeStateModel.recommendLicenses) { item in
                RecommendCeritificateTile(model: item)
                    .padding(.bottom, 16)
                    .onTapGesture {
                        viewModel.selectedLicenseId = item.id
                        viewModel.navigateToCertificateDetail()
                    }
            }
        }
        .padding(.bottom, 73)
    }
}
