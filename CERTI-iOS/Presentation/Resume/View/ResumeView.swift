//
//  ResumeView.swift
//  CERTI-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI

struct ResumeView: View {
    @EnvironmentObject var resumeCoordinator: ResumeCoordinator
    @ObservedObject var viewModel: ResumeViewModel
    @State var isPresented = false

    let columns = [GridItem(.flexible())]
    let rows = [GridItem(.fixed(100))]

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 0) {
                ResumeTopMainLogoView
                ResumeProfileView
                ResumeMyCertifivateTitleView
                ResumeMyCertificateView
                ResumeMyCareerTitleView
                ResumeMyCareerView
                ResumeMyExtracurricularActivityTitleView
                ResumeMyExtracurricularActivityView
            }
        }
        .scrollIndicators(.hidden)
        .overlay(
            Group {
                if isPresented {
                    ZStack {
                        Color.black.opacity(0.4)
                            .ignoresSafeArea()
                            .onTapGesture {
                                isPresented = false
                            }
                        
                        CertificateCardDetailView(viewModel: viewModel)
                            .shadow(radius: 10)
                    }
                    .zIndex(1)
                }
            }
        )
        .onAppear{
            Task {
                await viewModel.getJobList()
            }
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
        HStack(alignment: .center, spacing: 0){
            Image(.imageProfilePdf)
            
            VStack(alignment: .leading, spacing: 12){
                Text("희망직무")
                    .applyCertiFont(.body_semibold_16)
                    .foregroundStyle(.grayscale600)
                    .frame(height: 22)
                
                VStack(alignment: .leading, spacing: 0) {
                    if viewModel.jobList.count >= 3 {
                        HStack(alignment: .center, spacing: 0) {
                            Text(viewModel.jobList[0])
                                .applyCertiFont(.caption_regular_14)
                                .foregroundStyle(.mainblue)
                                .frame(height: 20)
                            
                            Image(systemName: "circle.fill")
                                .resizable()
                                .frame(width: 2, height: 2)
                                .padding(.leading, 4)
                                .padding(.trailing, 4)
                            
                            Text(viewModel.jobList[1])
                                .applyCertiFont(.caption_regular_14)
                                .foregroundStyle(.mainblue)
                                .frame(height: 20)
                        }
                        
                        HStack(alignment: .center, spacing: 0) {
                            Image(systemName: "circle.fill")
                                .resizable()
                                .frame(width: 2, height: 2)
                                .padding(.trailing, 4)
                            
                            Text(viewModel.jobList[2])
                                .applyCertiFont(.caption_regular_14)
                                .foregroundStyle(.mainblue)
                                .frame(height: 20)
                        }
                    } else if viewModel.jobList.count == 2 {
                        HStack(alignment: .center, spacing: 0) {
                            Text(viewModel.jobList[0])
                                .applyCertiFont(.caption_regular_14)
                                .foregroundStyle(.mainblue)
                                .frame(height: 20)
                            
                            Image(systemName: "circle.fill")
                                .resizable()
                                .frame(width: 2, height: 2)
                                .padding(.leading, 4)
                                .padding(.trailing, 4)
                            
                            Text(viewModel.jobList[1])
                                .applyCertiFont(.caption_regular_14)
                                .foregroundStyle(.mainblue)
                                .frame(height: 20)
                        }
                    } else {
                        Text(viewModel.jobList.joined(separator: ""))
                            .applyCertiFont(.caption_regular_14)
                            .foregroundStyle(.mainblue)
                            .frame(height: 20)
                        
                        Spacer()
                    }
                }
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
                resumeCoordinator.push(next: .myCertificateEdit)
            } label: {
                Image(.iconArrowright36)
            }
        }
        .frame(height: 36)
        .padding(.horizontal, 20)
    }
    
    private var ResumeMyCertificateView: some View {
            VStack(alignment: .leading, spacing: 0) {
                //                 취득한 자격증이 없을 때
                //                            Image(.imageEmpty)
                //                                .padding(.top, 60)
                //
                //                            Text("취득한 자격증이 없습니다.")
                //                                .applyCertiFont(.caption_regular_14)
                //                                .foregroundStyle(.grayscale400)
                //                                .frame(height: 20)
                //                                .padding(.bottom, 60)
                
                ScrollView(.horizontal) {
                    LazyHGrid(rows: rows, spacing: 12) {
                        ForEach($viewModel.certificatedDummy) { dummy in
                            CeritificateCardComponent()
                                .onTapGesture {
                                    isPresented.toggle()
                                }
                        }
                    }
                    .padding(.leading, 20)
                }
                .scrollIndicators(.hidden)
                .padding(.top, 16)
                
                Image(.resumeLine)
                    .resizable()
                    .scaledToFit()
                    .padding(.top, 36)
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
                resumeCoordinator.push(next: .myCareerEdit)
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
            //            경력사항 없을 때
            //            Image(.imageEmpty)
            //                .padding(.top, 60)
            //
            //            Text("경력사항을 추가해보세요!")
            //                .applyCertiFont(.caption_regular_14)
            //                .foregroundStyle(.grayscale400)
            //                .frame(height: 20)
            //                .padding(.bottom, 60)
            
            LazyVGrid(columns: columns, spacing: 24) {
                ForEach(viewModel.careerDummy) { dummy in
                    HStack(alignment: .center, spacing: 0) {
                        Image(.resumeList)
                            .frame(width: 24, height: 24)
                            .padding(.trailing, 24)
                            .padding(.top, 20.5)
                            .padding(.bottom, 29.5)
                        
                        ResumeActivityListComponent(model: dummy)
                            .frame(height: 74)
                    }
                    .padding(.horizontal, 20)
                }
            }
            
            Image(.resumeLine)
                .resizable()
                .scaledToFit()
                .padding(.bottom, 36)
        }
    }
    
    private var ResumeMyExtracurricularActivityTitleView: some View {
        HStack(alignment: .center, spacing: 0){
            Text("대내외 활동")
                .applyCertiFont(.sub_semibold_20)
                .foregroundStyle(.grayscale600)
                .frame(height: 26)
            
            Spacer()
            
            Button {
                resumeCoordinator.push(next: .myExtracurricularActivityEditView)
            } label: {
                Image(.iconArrowright36)
            }
        }
        .frame(height: 36)
        .padding(.horizontal, 20)
        .padding(.bottom, 16)
    }
    
    private var ResumeMyExtracurricularActivityView: some View {
        VStack(alignment: .leading, spacing: 0) {
            //                대내외 활동 없을 때
            //                Image(.imageEmpty)
            //                    .padding(.top, 60)
            //
            //                Text("대내외 활동을 추가해보세요!")
            //                    .applyCertiFont(.caption_regular_14)
            //                    .foregroundStyle(.grayscale400)
            //                    .frame(height: 20)
            //                    .padding(.bottom, 60)
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(viewModel.myExtracurricularActivityModelDummy) { dummy in
                    HStack(alignment: .center, spacing: 0) {
                        Image(.resumeList)
                            .frame(width: 24, height: 24)
                            .padding(.trailing, 24)
                            .padding(.top, 20.5)
                            .padding(.bottom, 29.5)
                        
                        ResumeActivityListComponent(model: dummy)
                            .frame(height: 74)
                    }
                    .padding(.horizontal, 20)
                }
            }
            .padding(.bottom, 54)
        }
    }
}
