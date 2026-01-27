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
        .task {
            async let favoriteList: () = viewModel.getFavoriteCertificates()
            async let expectedList: () = viewModel.fetchExpectedCertificate()
            async let completedList: () = viewModel.fetchCompletedCertificate()
            _ = await (favoriteList, expectedList, completedList)
        }
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
                Spacer()
                
                Button {
                    if !viewModel.expectedList.isEmpty {
                        viewModel.navigateToEditExpectedCertificate()
                    }
                } label: {
                    Text("편집")
                        .applyCertiFont(.body_semibold_16)
                        .foregroundStyle(.grayscale400)
                }
            }
            .frame(height: 38)
            .frame(maxWidth: .infinity)
            
            ForEach(viewModel.expectedList, id: \.id) {
                MyCertificationItem(
                    type: .expected(location: $0.city, time: $0.formattedTime),
                    title: $0.certificationName,
                    category: $0.agencyName,
                    description: $0.description,
                    actionConfig: .viewOnly
                )
            }
        }
    }
    
    @ViewBuilder
    private var completedListView: some View {
        VStack(alignment: .trailing) {
            HStack(alignment: .center) {
                Spacer()

                Button {
                    viewModel.navigateToEditCompletedCertificate()
                } label: {
                    Text("편집")
                        .applyCertiFont(.body_semibold_16)
                        .foregroundStyle(.grayscale400)
                }
            }
            .frame(height: 38)
            
            ForEach(viewModel.completedList, id: \.id) {
                MyCertificationItem(
                    type: .completed(date: $0.formattedDate, score: $0.grade),
                    title: $0.name,
                    category: $0.categoryText,
                    description: $0.description,
                    actionConfig: .viewOnly
                )
            }
        }
    }
    
    private var favoriteListView: some View {
        VStack(spacing: 16) {
            ForEach(viewModel.favoriteList, id: \.id) {
                FavoriteCertificationItem(
                    id: $0.id,
                    title: $0.certificationName,
                    category: $0.certificationType,
                    testType: $0.testType,
                    organization: $0.agencyName,
                    isFavorite: $0.isFavorite,
                    onToggle: { id in
                        Task {
                            await viewModel.toggleFavorite(id: id)
                        }
                    }
                )
            }
        }
        .padding(.top, 24)
        
    }
}
