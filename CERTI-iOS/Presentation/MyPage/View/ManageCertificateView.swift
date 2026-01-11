//
//  ManageCertificateView.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/12/26.
//

import SwiftUI

struct ManageCertificateView: View {
    private enum Tab: String, CaseIterable {
        case expected = "취득 예정"
        case completed = "취득 완료"
        case favorite = "즐겨찾기"
    }
    
    //MARK: - Property Wrappers

    @ObservedObject var viewModel: MyPageViewModel
    @State private var selectedTab: Tab = .expected
    @Namespace private var animation
    
    //MARK: - Main Body

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            MyPageHeader(style: .normal, title: "자격증 관리") {
                nil
            } backButtonAction: {
                viewModel.myPageViewRoutePop()
            }
            .padding(.bottom, 8)
            
            tabBar
            
            ScrollView {
                LazyVStack(alignment: .center, spacing: 16) {
                    switch selectedTab {
                    case .expected:
                        expectedListView
                    case .completed:
                        completedListView
                    case .favorite:
                        favoriteListView
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
            }
            .scrollIndicators(.hidden)
            
        }
        .background(.white)
    }
        
}


// MARK: - SubView

private extension ManageCertificateView {

    var tabBar: some View {
        HStack(alignment: .center, spacing: 0) {
            ForEach(Tab.allCases, id: \.self) { tab in
                Button {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        selectedTab = tab
                    }
                } label: {
                    VStack(alignment: .center, spacing: 10) {
                        Text(tab.rawValue)
                            .applyCertiFont(.body_bold_16)
                            .foregroundStyle(selectedTab == tab ? .grayscale600 : .grayscale300)
                        
                        if selectedTab == tab {
                            Rectangle()
                                .frame(height: 2)
                                .foregroundStyle(.grayscale600)
                                .matchedGeometryEffect(id: "underline", in: animation)
                        } else {
                            Rectangle()
                                .frame(height: 2)
                                .foregroundStyle(.clear)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
            }
        }
    }
        
    @ViewBuilder
    var expectedListView: some View {
        VStack(alignment: .trailing) {
            HStack(alignment: .center) {
                Button {
                    viewModel.navigateToEditExpectedCertificate()
                } label: {
                    Text("편집")
                        .applyCertiFont(.body_semibold_16)
                        .foregroundStyle(.grayscale400)
                }
            }
            .frame(height: 38)

            ForEach(0..<5) { _ in
                MyCertificationItem(
                    type: .expected(location: "고양시", time: "09:00"),
                    title: "정보처리기사",
                    category: "국가기술자격",
                    description: "소프트웨어 개발 관련 자격증으로, 계획수립, 분석, 설계, 구현...",
                    actionConfig: .viewOnly
                )
            }
        }
    }
    
    @ViewBuilder
    private var completedListView: some View {
        VStack(alignment: .trailing) {
            HStack(alignment: .center) {
                Button {
                    viewModel.navigateToEditCompletedCertificate()
                } label: {
                    Text("편집")
                        .applyCertiFont(.body_semibold_16)
                        .foregroundStyle(.grayscale400)
                }
            }
            .frame(height: 38)
            
            ForEach(0..<3) { _ in
                MyCertificationItem(
                    type: .completed(date: "2025. 11. 23", score: "IM3"),
                    title: "정보처리기사",
                    category: "국가기술자격",
                    description: "소프트웨어 개발 관련 자격증으로, 계획수립, 분석, 설계, 구현...",
                    actionConfig: .viewOnly
                )
            }
        }
    }
    
    private var favoriteListView: some View {
        VStack(spacing: 16) {
            FavoriteCertificationItem(
                title: "정보처리기사",
                category: "국가기술자격",
                testType: "실기형",
                organization: "한국산업인력공단"
            )
            FavoriteCertificationItem(
                title: "정보처리기사",
                category: "국가기술자격",
                testType: "필기형",
                organization: "한국산업인력공단"
            )
            FavoriteCertificationItem(
                title: "정보처리기사",
                category: "국가기술자격",
                testType: "실기형",
                organization: "한국산업인력공단"
            )
        }
        .padding(.top, 24)
        
    }
}
