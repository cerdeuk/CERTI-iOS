//
//  CertificateView.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/28/26.
//

import SwiftUI

struct CertificateView: View {
    @ObservedObject var viewModel: CertificateViewModel
    
    // 툴팁 표시 여부 상태 관리
    @State private var showRecommendationTooltip: Bool = false
    let username = "김서티"
    let track = "공학"
    let job = "경영사무"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            header
            
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    
                    // 추천 자격증
                    recommendationSection
                        .padding(.bottom, 20)
                    
                    // 공학계열 TOP3
                    trackRankingSection
                        .padding(.bottom, 20)
                    
                    // 경영사무 TOP3
                    jobRankingSection
                    
                    Color.clear.frame(height: 52)
                }
                .padding(.top, 24)
                .padding(.horizontal, 20)
            }
            .scrollIndicators(.hidden)
        }
        .onTapGesture {
            if showRecommendationTooltip {
                withAnimation {
                    showRecommendationTooltip = false
                }
            }
        }
        .task {
            async let recommend: () = viewModel.fetchRecommend()
            async let trackRank: () = viewModel.fetchTrackRank()
            async let jobRank: () = viewModel.fetchJobRank()
            async let job: () = viewModel.fetchJob()
            async let track: () = viewModel.fetchTrack()
            
            _ = await (recommend, trackRank, jobRank, job, track)
        }
    }
}

// MARK: - SubViews

private extension CertificateView {
    var header: some View {
        HStack(alignment: .bottom, spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                Rectangle()
                    .frame(width: 44, height: 24)
                    .foregroundStyle(.clear)
                
                Spacer()
                
                Text("모든 자격증")
                    .applyCertiFont(.sub_semibold_20)
                    .foregroundStyle(.black)
                
                Spacer()
                
                Button {
                    viewModel.navigateToSearch()
                } label: {
                    Image(.iconSearch24)
                }
                .padding(.trailing, 20)
            }
            .frame(height: 26)
        }
        .frame(height: 58)
        .overlay(alignment: .bottom) {
            Divider()
        }
    }
    
    var recommendationSection: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading, spacing: 0) {
                
                HStack(alignment: .center, spacing: 4) {
                    Text("\(username)님에게 추천하는 자격증")
                        .applyCertiFont(.sub_bold_20)
                    
                    Button {
                        showRecommendationTooltip.toggle()
                    } label: {
                        Image(.iconInfo24)
                    }
                }
                .padding(.bottom, 16)
                
                ForEach(viewModel.recommendCertificates) { item in
                    RecommendCeritificateTile(model: item)
                        .padding(.bottom, 16)
                        .onTapGesture {
                            viewModel.selectedLicenseId = item.id
                            viewModel.navigateToCertificateDetail()
                        }
                }
            }
            
            if showRecommendationTooltip {
                tooltipView
                    .padding(.trailing, 10)
                    .padding(.top, 28)
            }
        }
    }
    
    var tooltipView: some View {
        VStack(alignment: .leading, spacing: 3) {
            HStack(alignment: .center, spacing: 0) {
                Text("추천 기준")
                    .applyCertiFont(.caption_semibold_12)
                    .foregroundStyle(.grayscale500)
                
                Spacer()
                
                Button {
                    showRecommendationTooltip = false
                } label: {
                    Image(.iconClose20)
                }
            }
            
            Text("따요는 자체 알고리즘을 기반으로 사용자에게 적합한 자격증을 추천해주고 있어요.\n수많은 사용자 데이터를 학습하여 신뢰할 수 있는 결과를 제공합니다.")
                .applyCertiFont(.caption_regular_12)
                .foregroundStyle(.grayscale400)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(width: 216)
        .padding(.vertical, 6)
        .padding(.horizontal, 10)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.grayscale400, lineWidth: 1)
        )
    }
    
    var trackRankingSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .bottom) {
                Text("\(track)계열 자격증 TOP3")
                    .applyCertiFont(.sub_bold_20)
                    .foregroundStyle(.grayscale600)
                
                Spacer()
                
                Button {
                    viewModel.navigateTotrackList()
                } label: {
                    Text("계열별 자격증 더보기")
                        .applyCertiFont(.caption_regular_12)
                        .foregroundStyle(.grayscale400)
                }
            }
            .padding(.bottom, 16)
            
            ForEach(viewModel.trackRankCertificates) { item in
                RankCeritificateTile(model: item)
                    .onTapGesture {
                        viewModel.selectedLicenseId = item.id
                        viewModel.navigateToCertificateDetail()
                    }
                    .padding(.bottom, 16)
            }
        }
    }
    
    var jobRankingSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .bottom) {
                Text("\(job) 자격증 TOP3")
                    .applyCertiFont(.sub_bold_20)
                    .foregroundStyle(.grayscale600)
                
                Spacer()
                
                Button {
                    viewModel.navigateTojobList()
                } label: {
                    Text("직무별 자격증 더보기")
                        .applyCertiFont(.caption_regular_12)
                        .foregroundStyle(.grayscale400)
                }
            }
            .padding(.bottom, 16)
            
            ForEach(viewModel.jobRankCertificates) { item in
                RankCeritificateTile(model: item)
                    .onTapGesture {
                        viewModel.selectedLicenseId = item.id
                        viewModel.navigateToCertificateDetail()
                    }
                    .padding(.bottom, 16)
            }
        }
    }
    
}

#Preview {
    let tabCoordinator = CertiTabCoordinator()
    
    CertiTabBarCoordinatorView(
        tabCoordinator: tabCoordinator,
        appDIContainer: AppDIContainer.shared
    )
}
