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
    
    @State private var selectedJob: JobCategory = .business // 직무별
    @State private var selectedTrack: TrackList = .health   // 계열별
    @State private var isFavorite: Bool = false
    
    let dummyData = [
        (title: "정보처리기사", type: "국가기술자격", desc: "기업체 전산실, 소프트웨어 개발업체, SI업체 등...", tags: ["컴퓨터공학", "시각디자인", "경영"], test: "실기형", isFav: true),
        (title: "정보처리기사", type: "국가기술자격", desc: "기업체 전산실, 소프트웨어 개발업체, SI업체 등...", tags: ["컴퓨터공학", "시각디자인", "경영"], test: "실기형", isFav: false),
        (title: "정보처리기사", type: "국가기술자격", desc: "기업체 전산실, 소프트웨어 개발업체, SI업체 등...", tags: ["컴퓨터공학", "시각디자인", "경영"], test: "실기형", isFav: false),
        (title: "정보처리기사", type: "국가기술자격", desc: "기업체 전산실, 소프트웨어 개발업체, SI업체 등...", tags: ["컴퓨터공학", "시각디자인", "경영"], test: "실기형", isFav: true)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            header
                .padding(.horizontal, 20)
            
            Group {
                switch viewType {
                case .job:
                    JobCategorySegmentedControl(selectedCategory: $selectedJob)
                case .track:
                    TrackCategorySegmentedControl(selectedCategory: $selectedTrack)
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
                    ForEach(0..<dummyData.count, id: \.self) { index in
                        let item = dummyData[index]
                        
                        if !isFavorite || (isFavorite && item.isFav) {
                            CertificateListTile(
                                title: item.title,
                                type: item.type,
                                description: item.desc,
                                tags: item.tags,
                                testType: item.test,
                                isFavorite: item.isFav
                            ) {
                                // TODO: - 즐겨찾기 토글 API 연결
                            }
                        }
                    }
                }
                .padding(.bottom, 20)
            }
            .scrollIndicators(.hidden)
        }
        .background(.white)
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
                // 검색탭 이동
            } label: {
                Image(.iconSearch24)
            }
        }
        .frame(height: 56)
    }
}

#Preview {
    CertificateListView(viewModel: CertificateViewModel(), viewType: .job)
}
