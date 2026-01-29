//
//  CertificateListView.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/28/26.
//

import SwiftUI

enum CertificateListViewType {
    case job    // 직무별
    case track  // 계열별
    
    var title: String {
        switch self {
        case .job: return "직무별 자격증"
        case .track: return "계열별 자격증"
        }
    }
}

struct CertificateListView: View {
    @ObservedObject var viewModel: CertificateViewModel
    
    let viewType: CertificateListViewType
    
    @State private var isFavorite: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            header
                .padding(.horizontal, 20)
            
            Group {
                switch viewType {
                case .job:
                    JobCategorySegmentedControl(selectedCategory: $viewModel.selectedJob)
                case .track:
                    TrackCategorySegmentedControl(selectedCategory: $viewModel.selectedTrack)
                }
            }
            .padding(.top, 12)
            .padding(.bottom, 12)
            
            Divider()
                .foregroundStyle(.grayscale100)
            
            Button {
                isFavorite.toggle()
            } label: {
                Text("즐겨찾기")
                    .applyCertiFont(.caption_semibold_12)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .foregroundStyle(.mainblue)
                    .background(.white)
                    .clipShape(Capsule())
                    .overlay( Capsule().stroke(.mainblue, lineWidth: 1) )
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 20)
            
            ScrollView {
                Divider()
                    .foregroundStyle(.grayscale100)
                
                LazyVStack(alignment: .leading, spacing: 0) {
                    ForEach(viewModel.licenseCards) { item in
                        if !isFavorite || (isFavorite && item.isFavorite) {
                            CertificateListTile(
                                title: item.title,
                                type: item.type,
                                description: item.description,
                                tags: item.tags,
                                testType: item.testType,
                                isFavorite: item.isFavorite
                            ) {
                                Task {
                                    await viewModel.toggleFavorite(id: item.id)
                                }
                            }
                            .onTapGesture {
                                viewModel.selectedLicenseId = item.id
                                viewModel.navigateToCertificateDetail()
                            }
                        }
                    }
                }
                .padding(.bottom, 20)
            }
            .scrollIndicators(.hidden)
        }
        .background(.white)
        .task(id: viewModel.selectedJob) {
            guard viewType == .job else { return }
            await viewModel.fetchJobList()
        }
        .task(id: viewModel.selectedTrack) {
            guard viewType == .track else { return }
            await viewModel.fetchTrackList()
        }
    }
}


// MARK: - SubViews

private extension CertificateListView {
    var header: some View {
        HStack(alignment: .center, spacing: 0) {
            Button {
                viewModel.certificateViewRoutePop()
            } label: {
                Image(.iconArrowleft36)
            }
            
            Spacer()
            
            Text(viewType.title)
                .applyCertiFont(.sub_semibold_20)
                .foregroundStyle(.grayscale600)
            
            Spacer()
            
            Button {
                viewModel.navigateToSearch()
            } label: {
                Image(.iconSearch24)
            }
        }
        .frame(height: 56)
    }
}
