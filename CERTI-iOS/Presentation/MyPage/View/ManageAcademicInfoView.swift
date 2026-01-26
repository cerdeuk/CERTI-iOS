//
//  ManageAcademicInfoView.swift
//  CERTI-iOS
//
//  Created by OneTen on 10/29/25.
//

import SwiftUI

struct ManageAcademicInfoView: View {
    @ObservedObject var viewModel: MyPageViewModel
    
    @State var isModalPresented: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            MyPageHeader(style: .normal, title: "학사정보 및 희망직무 관리") {
                nil
            } backButtonAction: {
                viewModel.myPageViewRoutePop()
            }
            
            Text("학사정보")
                .applyCertiFont(.body_semibold_16)
                .foregroundStyle(.grayscale600)
                .frame(height: 22)
                .padding(.top, 32)
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            
            Button {
                viewModel.navigateToEditUniversity()
            } label: {
                HStack(alignment: .center, spacing: 0) {
                    Text("대학교 변경")
                        .applyCertiFont(.body_semibold_16)
                        .foregroundStyle(.black)
                        .frame(height: 22)
                    
                    Spacer()
                    
                    Image(.iconArrowright24)
                }
                .padding(.horizontal, 20)
            }
            .frame(height: 24)
            .padding(.bottom, 16)
            
            Button {
                viewModel.navigateToEditMajor()
            } label: {
                HStack(alignment: .center, spacing: 0) {
                    Text("학과 변경")
                        .applyCertiFont(.body_semibold_16)
                        .foregroundStyle(.black)
                        .frame(height: 22)
                    
                    Spacer()
                    
                    Image(.iconArrowright24)
                }
                .padding(.horizontal, 20)
            }
            .frame(height: 24)
            .padding(.bottom, 24)
            
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(.grayscale100)
                .padding(.bottom, 24)
            
            Text("희망직무")
                .applyCertiFont(.body_semibold_16)
                .foregroundStyle(.grayscale600)
                .frame(height: 22)
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            
            HStack(alignment: .center, spacing: 8) {
                ForEach(viewModel.jobCategoryList, id: \.self) { category in
                    Text(category.description)
                        .applyCertiFont(.caption_regular_12)
                        .frame(height: 18)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .foregroundColor(.grayscale600)
                        .background(
                            RoundedRectangle(cornerRadius: 24)
                                .foregroundStyle(.grayscale0)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 12)
            
            Button {
                isModalPresented.toggle()
            } label: {
                Text("희망분야 재설정하기")
                    .applyCertiFont(.caption_semibold_12)
                    .frame(height: 18)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .foregroundColor(.mainblue)
                    .background(
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(Color.mainblue, lineWidth: 1)
                    )
            }
            .padding(.horizontal, 20)
            
            Spacer()
        }
        .sheet(isPresented: $isModalPresented) {
            JobCategoryFilterModal(viewModel: viewModel)
                .presentationDetents([.height(548)])
                .presentationCornerRadius(40)
                .presentationDragIndicator(.visible)
        }
    }
}
