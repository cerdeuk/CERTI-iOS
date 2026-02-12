//
//  MyPageView.swift
//  CERTI-iOS
//
//  Created by OneTen on 10/17/25.
//

import SwiftUI
import Kingfisher

struct MyPageView: View {
    @Environment(\.openURL) var openURL

    @ObservedObject var viewModel: MyPageViewModel
    
    private let tabIconList: [UIImage] = [.iconPerson24, .iconSchool24, .iconPencil24, .iconSetting24, .iconMessage24]
    private let tabList: [String] = ["개인 정보 수정", "학사정보 관리", "자격증 관리", "설정", "문의사항"]
    private let tabDescriptionList: [String] = ["프로필 사진 및 개인 정보 수정", "학교/학과 정보 및 희망직무 설정", "즐겨찾기 자격증 및 취득 자격증 관리", "비밀번호 변경 및 계정 관련", "오픈채팅 바로가기"]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 0) {
                
                userInfo
                    .frame(maxWidth: .infinity)
                    .background(.white)
                
                // 회색 배경 영역
                VStack(alignment: .center, spacing: 16) {
                    // 자격증 관리
                    Button {
                        viewModel.navigateToManageCertificates()
                    } label: {
                        VStack(alignment: .center, spacing: 0) {
                            HStack(alignment: .center, spacing: 0){
                                Image(.iconFile24)
                                    .foregroundStyle(.grayscale400)
                                    .padding(.vertical, 22)
                                    .padding(.leading, 18)
                                
                                Text("자격증 관리")
                                    .applyCertiFont(.caption_semibold_14)
                                    .foregroundStyle(.black)
                                    .frame(height: 20)
                                    .padding(.leading, 8)
                                
                                Spacer()
                                
                                Image(.iconArrowright24)
                                    .padding(.trailing, 12)
                            }
                            
                            HStack(alignment: .center, spacing: 30) {
                                VStack(alignment: .center, spacing: 8) {
                                    Text("취득 예정")
                                        .applyCertiFont(.caption_regular_14)
                                        .foregroundStyle(.grayscale500)
                                        .frame(height: 20)
                                    
                                    Text("\(viewModel.upCertificationCount)개")
                                        .applyCertiFont(.caption_semibold_14)
                                        .foregroundStyle(.grayscale600)
                                        .frame(height: 20)
                                }
                                
                                Rectangle()
                                    .frame(width: 1)
                                    .padding(.vertical, 1)
                                    .foregroundStyle(.grayscale100)
                                
                                VStack(alignment: .center, spacing: 8) {
                                    Text("취득 완료")
                                        .applyCertiFont(.caption_regular_14)
                                        .foregroundStyle(.grayscale500)
                                        .frame(height: 20)
                                    
                                    Text("\(viewModel.acCertificationCount)개")
                                        .applyCertiFont(.caption_semibold_14)
                                        .foregroundStyle(.grayscale600)
                                        .frame(height: 20)
                                }
                                
                                Rectangle()
                                    .frame(width: 1)
                                    .padding(.vertical, 1)
                                    .foregroundStyle(.grayscale100)
                                
                                VStack(alignment: .center, spacing: 8) {
                                    Text("즐겨찾기")
                                        .applyCertiFont(.caption_regular_14)
                                        .foregroundStyle(.grayscale500)
                                        .frame(height: 20)
                                    
                                    Text("\(viewModel.fCertificationCount)개")
                                        .applyCertiFont(.caption_semibold_14)
                                        .foregroundStyle(.grayscale600)
                                        .frame(height: 20)
                                }
                                
                            }
                            .padding(.horizontal, 35)
                            .padding(.bottom, 24)
                        }
                    }
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.top, 20)
                    .padding(.horizontal, 20)
                    
                    // 개인 정보 수정
                    myPageViewButton(icon: tabIconList[0], title: tabList[0], description: tabDescriptionList[0], action: {
                        viewModel.navigateToEditProfile()
                    })
                    .padding(.horizontal, 20)
                    
                    // 학사정보 관리
                    myPageViewButton(icon: tabIconList[1], title: tabList[1], description: tabDescriptionList[1], action: {
                        viewModel.navigateToManageAcademicInfo()
                    })
                    .padding(.horizontal, 20)
                    
                    // 설정으로 이동
                    myPageViewButton(icon: tabIconList[3], title: tabList[3], description: tabDescriptionList[3], action: {
                        viewModel.navigateToSettings()
                    })
                    .padding(.horizontal, 20)
                    
                    // 문의사항으로 이동
                    myPageViewButton(icon: tabIconList[4], title: tabList[4], description: tabDescriptionList[4], action: {
                        openURL(URL(string: "https://open.kakao.com/o/sTZ4Jwfi")!)
                    })
                    .padding(.horizontal, 20)

                    Rectangle()
                        .foregroundStyle(.grayscale0)
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                    
                    Spacer()
                }
                .background(.grayscale0)
                
                Spacer()
            }
            .background(.white)
        }
        .task {
            await viewModel.fetchMyPageInfo()
        }
        .scrollIndicators(.hidden)
    }
}

extension MyPageView {
    @ViewBuilder
    private var userInfo: some View {
        if viewModel.profileImageURL.isEmpty {
            ZStack(alignment: .center) {
                Circle()
                    .frame(width: 80, height: 80)
                    .foregroundStyle(.grayscale100)
                
                // TODO: - User Profile Image 없으면 보여주는 이미지, 나중에 이미지 업로드 구현 시 분기처리
                Image(.iconImage24)
                    .foregroundStyle(.grayscale300)
            }
            .padding(.bottom, 16)
            .padding(.top, 52)
        } else {
            KFImage(URL(string: viewModel.profileImageURL))
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
                .padding(.bottom, 16)
                .padding(.top, 52)
        }

        Text(viewModel.userNickName)
            .applyCertiFont(.sub_bold_20)
            .foregroundStyle(.mainblue)
            .frame(height: 26)
            .padding(.bottom, 4)
        
        Text(viewModel.userEmail)
            .applyCertiFont(.caption_regular_14)
            .foregroundStyle(.grayscale500)
            .frame(height: 20)
            .padding(.bottom, 16)
        
        HStack(alignment: .center, spacing: 8) {
            ForEach(viewModel.jobCategoryList, id: \.self) { job in
                Text(job.description)
                    .applyCertiFont(.caption_semibold_14)
                    .foregroundStyle(.mainblue)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .background(.purplewhite)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
        .padding(.bottom, 20)
    }
    
    @ViewBuilder
    private func myPageViewButton(icon: UIImage, title: String, description: String, action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            HStack(alignment: .center, spacing: 0){
                Image(uiImage: icon)
                    .foregroundStyle(.grayscale400)
                    .padding(.vertical, 22)
                    .padding(.leading, 18)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .applyCertiFont(.caption_semibold_14)
                        .foregroundStyle(.black)
                        .frame(height: 20)
                    
                    Text(description)
                        .applyCertiFont(.caption_regular_12)
                        .foregroundStyle(.grayscale600)
                        .frame(height: 18)
                }
                .padding(.leading, 18)
                
                Spacer()
                
                Image(.iconArrowright24)
                    .padding(.trailing, 12)
            }
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
    
    
}
