//
//  ResumeView.swift
//  CERTI-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI

struct ResumeView: View {
    @EnvironmentObject var resumeCoordinator: ResumeCoordinator

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 0) {
                TopMainLogoView
                ProfileView
                CertificatedView
                CareerView
                ExtracurricularActivityView
            }
        }
        .scrollIndicators(.hidden)
    }
}

private var TopMainLogoView: some View {
        HStack{
            Image(.imageLogoBlack)
            Spacer()
        }
        .padding(.bottom, 36)
        .padding(.horizontal, 20)

    }

private var ProfileView: some View {
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

private var CertificatedView: some View {
        VStack{
            HStack{
                Text("취득한 자격증")
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
            
            Text("취득한 자격증이 없습니다.")
                .applyCertiFont(.caption_regular_14)
                .foregroundStyle(.grayscale400)
                .padding(.bottom, 60)
            
            Image(.resumeLine)
                .padding(.bottom, 36)
        }
    }

private var CareerView: some View {
    VStack{
        HStack{
            Text("경력사항")
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
        
        Text("경력사항을 추가해보세요!")
            .applyCertiFont(.caption_regular_14)
            .foregroundStyle(.grayscale400)
            .padding(.bottom, 60)
        
        Image(.resumeLine)
            .padding(.bottom, 36)
    }
}

private var ExtracurricularActivityView: some View {
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
