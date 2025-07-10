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
                ResumeMyCertificateView(isPresented: $isPresented)
                ResumeMyCareerView
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
                        
                        CertificateCardDetailView()
                            .shadow(radius: 10)
                    }
                    .zIndex(1)
                }
            }
        )
    }
}

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
                Text("IT/인터넷·경영/사무·경영/사무")
                    .applyCertiFont(.caption_regular_14)
                    .foregroundStyle(.mainblue)
            }
            Spacer()
        }
        .padding(.bottom, 36)
        .padding(.horizontal, 20)
    }

private struct ResumeMyCertificateView: View {
    let rows = [
        GridItem(.fixed(100))
    ]
    @Binding var isPresented: Bool
    
    let CertificatedDummy: [CertificatedModel] = CertificatedModel.dummy()

    var body: some View {
        VStack{
            HStack{
                Text("취득한 자격증")
                    .applyCertiFont(.sub_semibold_20)
                    .foregroundStyle(.grayscale600)
                Spacer()
                Button {
                    print("취득한 자격증 편집")
                } label: {
                    Image(.iconArrowright36)
                }
            }
            .padding(.horizontal, 20)
            
            // 취득한 자격증이 없을 때
            //            Image(.imageEmpty)
            //                .padding(.top, 60)
            //
            //            Text("취득한 자격증이 없습니다.")
            //                .applyCertiFont(.caption_regular_14)
            //                .foregroundStyle(.grayscale400)
            //                .padding(.bottom, 60)
            //

            ScrollView(.horizontal) {
                LazyHGrid(rows: rows, spacing: 12) {
                    ForEach(CertificatedDummy) { dummy in
                        ResumeMyCertificateItems(isPresented: $isPresented, cardImage: dummy.cardFrontImageUrl, name: dummy.name, date: dummy.createdAt, certiTag: dummy.tag)
                    }
                }
                .padding(.leading, 20)
            }
            .scrollIndicators(.hidden)
            
            Image(.resumeLine)
                .padding(.top, 36)
                .padding(.bottom, 36)
        }
    }
}

struct ResumeMyCertificateItems: View {
    @Binding var isPresented: Bool
    
    var cardImage: String = ""
    var name: String = ""
    var date: String = ""
    var certiTag: [String]

    var body: some View {
            ZStack(alignment: .top) {
                Image(cardImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 300)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(name)
                        .foregroundStyle(.grayscale600)
                        .applyCertiFont(.caption_bold_14)
                        .frame(height: 20)
                        .padding(.top, 32)
                    
                    Text(date)
                        .applyCertiFont(.caption_regular_12)
                        .foregroundStyle(.grayscale600)
                        .frame(height: 18)
                        .padding(.top, 4)
                    
                    TagChip(tags: certiTag, spacing: 4)
                        .padding(.top, 8)
                        .frame(height: 23)
                }
            }
            .onTapGesture {
                    isPresented = true
            }
        }
    }

private var ResumeMyCareerView: some View {
    VStack{
        HStack{
            Text("경력사항")
                .applyCertiFont(.sub_semibold_20)
                .foregroundStyle(.grayscale600)
            Spacer()
            Button {
                //누르면 편집 뷰
            } label: {
                Image(.iconArrowright36)
            }
        }
        .padding(.horizontal, 20)
        
        Image(.imageEmpty)
            .padding(.top, 60)
        
        Text("경력사항을 추가해보세요!")
            .applyCertiFont(.caption_regular_14)
            .foregroundStyle(.grayscale400)
            .padding(.bottom, 60)
        
        Image(.resumeLine)
            .padding(.bottom, 36)
    }
}

private var ResumeMyExtracurricularActivityView: some View {
    VStack{
        HStack{
            Text("대내외 활동")
                .applyCertiFont(.sub_semibold_20)
                .foregroundStyle(.grayscale600)
            Spacer()
            Button {
                //누르면 편집
            } label: {
                Image(.iconArrowright36)
            }
        }
        .padding(.horizontal, 20)
        
        Image(.imageEmpty)
            .padding(.top, 60)
        
        Text("대내외 활동을 추가해보세요!")
            .applyCertiFont(.caption_regular_14)
            .foregroundStyle(.grayscale400)
            .padding(.bottom, 60)
    }
}

#Preview {
    ResumeView()
}
