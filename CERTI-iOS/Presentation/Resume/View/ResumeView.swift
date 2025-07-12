//
//  ResumeView.swift
//  CERTI-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI

struct ResumeView: View {
    @EnvironmentObject var resumeCoordinator: ResumeCoordinator
    @State private var isPresented = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 0) {
                ResumeTopMainLogoView
                ResumeProfileView
                ResumeMyCertifivateTitleView
                ResumeMyCertificateView(isPresented: $isPresented)
                ResumeMyCareerTitleView
                ResumeMyCareerView()
                ResumeMyExtracurricularActivityTitleView
                ResumeMyExtracurricularActivityView()
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
                        
                        CertificateCardDetailView()
                            .shadow(radius: 10)
                    }
                    .zIndex(1)
                }
            }
        )
    }
}

extension ResumeView {
    private var ResumeTopMainLogoView: some View {
        HStack{
            Image(.imageLogoBlack)
            
            Spacer()
        }
        .padding(.bottom, 36)
        .padding(.horizontal, 20)
    }
    
    private var ResumeProfileView: some View {
        HStack{
            Image(.imageProfilePdf)
            
            VStack(alignment: .leading, spacing: 12){
                Text("희망직무")
                    .applyCertiFont(.body_semibold_16)
                    .foregroundStyle(.grayscale600)
                    .frame(height: 22)
                
                Text("IT/인터넷·경영/사무  ·경영/사무")
                    .applyCertiFont(.caption_regular_14)
                    .foregroundStyle(.mainblue)
                    .frame(width: 118, height: 42)
            }
            Spacer()
        }
        .padding(.bottom, 36)
        .padding(.horizontal, 20)
    }
    
    private var ResumeMyCertifivateTitleView: some View {
        HStack{
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
    
    private struct ResumeMyCertificateView: View {
        @Binding var isPresented: Bool
        
        let rows = [
            GridItem(.fixed(100))
        ]
        
        let CertificatedDummy: [CertificatedModel] = CertificatedModel.dummy()
        
        var body: some View {
            VStack(spacing: 0) {
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
                        ForEach(CertificatedDummy) { dummy in
                            CeritificateCardComponent(cardImage: dummy.cardFrontImageUrl, name: dummy.name, date: dummy.createdAt, certiTag: dummy.tag)
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
                    .padding(.top, 36)
                    .padding(.bottom, 36)
            }
            
        }
    }
    
    private var ResumeMyCareerTitleView: some View {
        HStack{
            Text("경력사항")
                .applyCertiFont(.sub_semibold_20)
                .foregroundStyle(.grayscale600)
                .frame(height: 26)
            
            Spacer()
            
            Button {
                //                resumeCoordinator.push(next: .myCertificateEdit)
            } label: {
                Image(.iconArrowright36)
            }
        }
        .frame(height: 36)
        .padding(.horizontal, 20)
    }
    
    private struct ResumeMyCareerView: View {
        let columns = [GridItem(.fixed(335))]
        let careerDummy: [ResumeModel] = ResumeModel.myCareerDummy()
        
        var body: some View {
            VStack {
                //            경력사항 없을 때
                //            Image(.imageEmpty)
                //                .padding(.top, 60)
                //
                //            Text("경력사항을 추가해보세요!")
                //                .applyCertiFont(.caption_regular_14)
                //                .foregroundStyle(.grayscale400)
                //                .frame(height: 20)
                //                .padding(.bottom, 60)
                
                LazyVGrid(columns: columns, spacing: 0) {
                    ForEach(careerDummy) { dummy in
                        ResumeLoadMapComponent(model: dummy)
                    }
                }
                
                Image(.resumeLine)
                    .padding(.bottom, 36)
            }
        }
    }
    
    private var ResumeMyExtracurricularActivityTitleView: some View {
        HStack{
            Text("대내외 활동")
                .applyCertiFont(.sub_semibold_20)
                .foregroundStyle(.grayscale600)
                .frame(height: 26)
            
            Spacer()
            
            Button {
                //                resumeCoordinator.push(next: .myCertificateEdit)
            } label: {
                Image(.iconArrowright36)
            }
        }
        .frame(height: 36)
        .padding(.horizontal, 20)
    }
    
    private struct ResumeMyExtracurricularActivityView: View {
        let columns = [GridItem(.fixed(335))]
        let myExtracurricularActivityModelDummy: [ResumeModel] = ResumeModel.myExtracurricularActivityDummy()
        
        var body: some View {
            VStack {
//                대내외 활동 없을 때
//                Image(.imageEmpty)
//                    .padding(.top, 60)
//                
//                Text("대내외 활동을 추가해보세요!")
//                    .applyCertiFont(.caption_regular_14)
//                    .foregroundStyle(.grayscale400)
//                    .frame(height: 20)
//                    .padding(.bottom, 60)
                LazyVGrid(columns: columns, spacing: 0) {
                    ForEach(myExtracurricularActivityModelDummy) { model in
                        ResumeLoadMapComponent(model: model)
                    }
                }
                .padding(.bottom, 54)
            }
        }
    }
}
#Preview {
    ResumeView()
}
