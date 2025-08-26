//
//  OnboardingTrackView.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/12/25.
//

import SwiftUI

struct OnboardingTrackView: View {
    @ObservedObject var viewModel: OnboardingViewModel

    private let trackOptions = ["인문계열", "사회계열", "교육계열", "자연계열", "공학계열", "의약계열", "예체능계열"]
    
    private let columns = [
        GridItem(.flexible(), spacing: 17),
        GridItem(.flexible(), spacing: 17)
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            BackButton {
                viewModel.onboardingViewRoutePop()
            }
            .padding(.bottom, 13)
            
            Image(.onboardingProgressbar3)
                .padding(.leading, 20)
                .padding(.bottom, 40)
            
            Text("계열을 선택해주세요")
                .applyCertiFont(.sub_bold_20)
                .foregroundStyle(.grayscale600)
                .padding(.leading, 20)
                .padding(.bottom, 58)
            
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(trackOptions, id: \.self) { track in
                    Button {
                        if viewModel.selectedTrack == track {
                            viewModel.selectedTrack = ""
                        } else {
                            viewModel.selectedTrack = track
                        }
                    } label: {
                        Text(track)
                            .applyCertiFont(viewModel.selectedTrack == track ? .body_semibold_16 : .body_regular_16)
                            .foregroundColor(viewModel.selectedTrack == track ? .grayscale600 : .grayscale500)
                            .frame(maxWidth: .infinity, minHeight: 80)
                            .background(viewModel.selectedTrack == track ? .lightblue : .bluewhite)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(viewModel.selectedTrack == track ? .skyblue : .lightblue , lineWidth: 1)
                            }
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 22)
            
            Spacer()
            
            Button {
                viewModel.navigateToMajor()
            } label: {
                Text("다음")
                    .applyCertiFont(.body_semibold_16)
                    .foregroundColor(viewModel.selectedTrack.isEmpty ? .grayscale400 : .white)
                    .frame(maxWidth: .infinity, minHeight: 56)
                    .background(viewModel.selectedTrack.isEmpty ? .grayscale100 : .purpleblue)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .disabled(viewModel.selectedTrack.isEmpty)
            .padding(.horizontal, 20)
            .padding(.bottom, 22)
        }
    }
}
