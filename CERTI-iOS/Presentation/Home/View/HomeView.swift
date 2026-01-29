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

                    preLicenseTitle
                        .padding(.horizontal, 20)
                    
                    // 값이 없으면 나타내는 뷰
                    if viewModel.homeStateModel.preLicenses.isEmpty {
                        preLicenseEmptyView
                    } else {
                        preLicenseList
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
                async let preCertifications: () = viewModel.fetchPreCertification()
                async let favoriteList: () = viewModel.getFavoriteCertificationList()

                _ = await (userInfo, recommendList, preCertifications, favoriteList)
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
    
    private var preLicenseTitle: some View {
        HStack(alignment: .center, spacing: 0) {
            Text("취득 예정 자격증")
                .frame(height: 26)
            
            Spacer()
            
            Button {
                viewModel.navigateToPreLicenseEdit()
            } label: {
                Image(.iconArrowright36)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 36, height: 36)
            }
        }
        .frame(height: 36)
        .foregroundStyle(.grayscale600)
        .applyCertiFont(.body_semibold_16)
        .padding(.top, 16)
        .padding(.bottom, 16)
    }
    
    private var preLicenseList: some View {
        ScrollView(.horizontal){
            LazyHGrid(rows: rows, spacing: 12) {
                ForEach(viewModel.homeStateModel.preLicenses, id: \.certificationId) { item in
                    PreLicenseCard(licenseCard: item)
                        .shadow(color: .black.opacity(0.08), radius: 12, x: 4, y: 4)
                        .onTapGesture {
                            viewModel.selectedLicenseId = item.id
                            viewModel.navigateToCertificateDetail()
                        }
                }
            }
            .padding(.horizontal, 20)

        }
        .frame(height: 132)
        .padding(.bottom, 36)
        .scrollIndicators(.hidden)
    }
    
    private var preLicenseEmptyView: some View {
        VStack(alignment: .center, spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                Spacer()
                Image(.imageEmpty)
                Spacer()
            }
            .padding(.bottom, 20)
            
            Text("취득 예정 자격증이 없습니다.")
                .applyCertiFont(.caption_regular_14)
                .foregroundStyle(.grayscale400)
                .frame(height: 20)

        }
        .padding(.top, 44)
        .padding(.bottom, 35)
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
        .padding(.bottom, 81)
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
        .padding(.top, 44)
        .padding(.bottom, 98)
    }
    
    private var recommendLicenseTitle: some View {
        HStack(alignment: .center, spacing: 0) {
            Text(viewModel.homeStateModel.username.trimmedUsername())
                .frame(height: 26)
            
            Text("님에게 추천하는 자격증")
                .frame(height: 26)
            
            Spacer()
            
            Button {
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
        LazyVGrid(columns: columns, spacing: 12) {
            ForEach(viewModel.homeStateModel.recommendLicenses.prefix(3)) { item in
                RecommendLicenseCard(licenseCard: item)
                    .frame(maxWidth: .infinity)
                    .onTapGesture {
                        viewModel.selectedLicenseId = item.id
                        viewModel.navigateToCertificateDetail()
                    }
                
            }
        }
        .frame(height: 264)
        .padding(.bottom, 36)
    }
}
