//
//  ResumeView.swift
//  CERTI-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI

import Kingfisher

struct ResumeView: View {
    @EnvironmentObject var tabRouter: CertiTabCoordinator
    @ObservedObject var viewModel: ResumeViewModel
    @State private var selectedCard: CertificatedDetailModel? = nil

    let columns = [GridItem(.flexible())]
    let rows = [GridItem(.flexible())]

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 0) {
                ResumeTopMainLogoView
                ResumeProfileView
                ResumeMyCertifivateTitleView
                ResumeMyCertificateView
                ResumeMyCareerTitleView
                ResumeMyCareerView
                ResumeMyActivityTitleView
                ResumeMyActivityView
            }
        }
        .scrollIndicators(.hidden)
        .overlay(alignment: .center){
            Group {
                if viewModel.isCardDetailPresented,
                   let selectedCard = viewModel.acquisitionDetail {
                    ZStack {
                        Color.blackOpacity40
                            .ignoresSafeArea()
                            .onTapGesture {
                                viewModel.isCardDetailPresented = false
                            }
                        
                        CertificateCardDetailView(card: selectedCard)
                            .shadow(radius: 10)
                    }
                    .zIndex(1)
                }
            }
        }
        .task {
            async let userInfomation: () = viewModel.getUserInfo()
            async let jobList: () = viewModel.getJobList()
            async let acquisitionList: () = viewModel.getAcquisitionList()
            async let careersList: () = viewModel.getCareersList()
            async let activityList: () = viewModel.getActivityList()
            
            _ = await (userInfomation, jobList, acquisitionList, careersList, activityList)
        }
    }
}

extension ResumeView {
    private var ResumeTopMainLogoView: some View {
        HStack(alignment: .center, spacing: 0){
            Image(.imageLogoBlack)
            
            Spacer()
        }
        .padding(.top, 12)
        .padding(.bottom, 36)
        .padding(.horizontal, 20)
    }
    
    private var ResumeProfileView: some View {
        HStack(alignment: .top, spacing: 0){
            if let url = URL(string: viewModel.resumeUserModel.profileImage),
               !viewModel.resumeUserModel.profileImage.isEmpty {
                KFImage(url)
                    .resizable()
                    .placeholder {
                        Color.grayscale100
                    }
                    .retry(maxCount: 3, interval: .seconds(5))
                    .onFailure { error in
                        print("failure: \(error.localizedDescription)")
                    }
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .clipShape(.circle)
                    .clipped()
                    .padding(.trailing, 12)
            } else {
                Image(.imageProfilePdf)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .padding(.trailing, 12)
            }
            
            VStack(alignment: .leading, spacing: 0) {
                HStack{
                    Text(viewModel.resumeUserModel.name)
                        .applyCertiFont(.body_semibold_16)
                        .foregroundStyle(.grayscale600)
                        .frame(height: 22)
                        .padding(.top, 4)
                    
                    Spacer()
                    
                    Button {
                        viewModel.navigateToEditProfile()
                    } label: {
                        HStack(alignment: .center, spacing: 0) {
                            Image(.iconEdit16)
                            
                            Text("정보 수정")
                                .applyCertiFont(.caption_semibold_12)
                                .foregroundStyle(.grayscale400)
                                .padding(.leading, 3)
                        }
                    }
                }
                
                HStack(alignment: .center, spacing: 8) {
                    Text("학교")
                        .applyCertiFont(.caption_regular_14)
                        .foregroundStyle(.grayscale400)
                    
                    Divider()
                        .frame(height: 14)
                        .foregroundStyle(.grayscale200)
                    
                    Text(viewModel.resumeUserModel.university)
                        .applyCertiFont(.caption_semibold_14)
                        .foregroundStyle(.grayscale600)
                }
                .padding(.top, 8)
                
                HStack(alignment: .center, spacing: 8) {
                    Text("학과")
                        .applyCertiFont(.caption_regular_14)
                        .foregroundStyle(.grayscale400)
                    
                    Divider()
                        .frame(height: 14)
                        .foregroundStyle(.grayscale200)
                    
                    Text(viewModel.resumeUserModel.major)
                        .applyCertiFont(.caption_semibold_14)
                        .foregroundStyle(.grayscale600)
                }
                .padding(.top, 8)
                
                HStack(alignment: .center, spacing: 8) {
                    Text("생년월일")
                        .applyCertiFont(.caption_regular_14)
                        .foregroundStyle(.grayscale400)
                    
                    Divider()
                        .frame(height: 14)
                        .foregroundStyle(.grayscale200)
                    
                    Text(viewModel.resumeUserModel.birthDateAgeText)
                        .applyCertiFont(.caption_semibold_14)
                        .foregroundStyle((viewModel.resumeUserModel.birthDate != nil) ? .grayscale600 : .grayscale400)
                }
                .padding(.top, 8)
            }
            .padding(.leading, 12)
            Spacer()
        }
        .padding(.bottom, 36)
        .padding(.horizontal, 20)
    }
    
    private var ResumeMyCertifivateTitleView: some View {
        HStack(alignment: .center, spacing: 0){
            Text("취득한 자격증")
                .applyCertiFont(.sub_semibold_20)
                .foregroundStyle(.grayscale600)
                .frame(height: 26)
            
            Spacer()
            
            Button {
                viewModel.navigateToCertificatedEdit()
            } label: {
                Image(.iconArrowright36)
            }
        }
        .frame(height: 36)
        .padding(.horizontal, 20)
    }
    
    private var ResumeMyCertificateView: some View {
            VStack(alignment: .leading, spacing: 0) {
                if viewModel.acquisitionList.isEmpty {
                    VStack(alignment: .center, spacing: 0) {
                        Image(.imageEmpty)
                            .padding(.top, 60)
                        
                        Text("취득한 자격증이 없습니다.")
                            .applyCertiFont(.caption_regular_14)
                            .foregroundStyle(.grayscale400)
                            .frame(height: 20)
                            .padding(.bottom, 60)
                            .padding(.top, 20)
                    }
                    .frame(maxWidth: .infinity)
                } else {
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: rows, spacing: 12) {
                            ForEach(viewModel.acquisitionList) { cardItem in
                                CeritificateCardComponent(model: cardItem)
                                    .onTapGesture {
                                        Task {
                                            await viewModel.getAcquisitionDetail(id: cardItem.acquisitionId)
                                            if let detail = viewModel.acquisitionDetail,
                                               !detail.name.isEmpty {
                                                selectedCard = detail
                                                viewModel.isCardDetailPresented = true
                                            }
                                        }
                                    }
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    .scrollIndicators(.hidden)
                    .padding(.top, 16)
                    .padding(.bottom, 36)
                }
                
                Image(.resumeLine)
                    .resizable()
                    .scaledToFit()
                    .padding(.bottom, 36)
            }
    }
    
    private var ResumeMyCareerTitleView: some View {
        HStack(alignment: .center, spacing: 0){
            Text("경력사항")
                .applyCertiFont(.sub_semibold_20)
                .foregroundStyle(.grayscale600)
                .frame(height: 26)
            
            Spacer()
            
            Button {
                viewModel.navigateToCareerManage()
            } label: {
                Image(.iconArrowright36)
            }
        }
        .frame(height: 36)
        .padding(.horizontal, 20)
        .padding(.bottom, 16)
    }
    
    private var ResumeMyCareerView: some View {
        VStack(alignment: .leading, spacing: 0) {
            if viewModel.careersList.isEmpty {
                VStack(alignment: .center, spacing: 0) {
                    Image(.imageEmpty)
                        .padding(.top, 60)
                    
                    Text("경력사항을 추가해보세요!")
                        .applyCertiFont(.caption_regular_14)
                        .foregroundStyle(.grayscale400)
                        .frame(height: 20)
                        .padding(.bottom, 60)
                        .padding(.top, 20)
                }
                .frame(maxWidth: .infinity)
            } else {
                LazyVGrid(columns: columns, spacing: 24) {
                    ForEach(viewModel.careersList.prefix(4)) { item in
                        HStack(alignment: .center, spacing: 0) {
                            Image(.resumeList)
                                .frame(width: 24, height: 24)
                                .padding(.trailing, 24)
                                .padding(.top, 20.5)
                                .padding(.bottom, 29.5)
                            
                            ResumeCareerListComponent(model: item, onTapCard: {})
                                .frame(height: 74)
                        }
                        .padding(.horizontal, 20)
                    }
                }
                .padding(.bottom, 8)
            }
            
            Image(.resumeLine)
                .resizable()
                .scaledToFit()
                .padding(.bottom, 36)
        }
    }
    
    private var ResumeMyActivityTitleView: some View {
        HStack(alignment: .center, spacing: 0){
            Text("대내외 활동")
                .applyCertiFont(.sub_semibold_20)
                .foregroundStyle(.grayscale600)
                .frame(height: 26)
            
            Spacer()
            
            Button {
                viewModel.navigateToActivityManage()
            } label: {
                Image(.iconArrowright36)
            }
        }
        .frame(height: 36)
        .padding(.horizontal, 20)
        .padding(.bottom, 16)
    }
    
    private var ResumeMyActivityView: some View {
        VStack(alignment: .leading, spacing: 0) {
            if viewModel.activitiesList.isEmpty {
                VStack(alignment: .center, spacing: 0) {
                    Image(.imageEmpty)
                        .padding(.top, 60)
                    
                    Text("대내외 활동을 추가해보세요!")
                        .applyCertiFont(.caption_regular_14)
                        .foregroundStyle(.grayscale400)
                        .frame(height: 20)
                        .padding(.bottom, 82)
                        .padding(.top, 20)
                }
                .frame(maxWidth: .infinity)
            } else {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.activitiesList.prefix(4)) { item in
                        HStack(alignment: .center, spacing: 0) {
                            Image(.resumeList)
                                .frame(width: 24, height: 24)
                                .padding(.trailing, 24)
                                .padding(.top, 20.5)
                                .padding(.bottom, 29.5)
                            
                            ResumeActivityListComponent(model: item, onTapCard: {})
                                .frame(height: 74)
                        }
                        .padding(.horizontal, 20)
                    }
                }
                .padding(.bottom, 79)
            }
        }
    }
}
