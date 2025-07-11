//
//  OnboardingTrackView.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/12/25.
//

import SwiftUI

struct OnboardingTrackView: View {
    @EnvironmentObject private var onboardingCoordinator: OnboardingCoordinator
    @Binding var selectedtrack: String

    private let trackOptions = ["인문계열", "사회계열", "교육계열", "자연계열", "공학계열", "의약계열", "예체능계열"]
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            BackButton {
                onboardingCoordinator.pop()
            }
            .padding(.bottom, 13)
            
            Image(.onboardingProgressbar2)
                .padding(.leading, 20)
                .padding(.bottom, 40)
            
            Text("계열을 선택해주세요")
                .applyCertiFont(.sub_bold_20)
                .foregroundStyle(.grayscale600)
                .padding(.leading, 20)
                .padding(.bottom, 58)
            
            LazyVGrid(columns: columns, spacing: 17) {
                ForEach(trackOptions, id: \.self) { track in
                    Button {
                        if selectedtrack == track {
                            selectedtrack = ""
                        } else {
                            selectedtrack = track
                        }
                    } label: {
                        Text(track)
                            .applyCertiFont(.body_regular_16)
                            .foregroundColor(selectedtrack == track ? .grayscale600 : .grayscale500)
                            .frame(maxWidth: .infinity, minHeight: 80)
                            .background(selectedtrack == track ? .lightblue : .bluewhite)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(selectedtrack == track ? .skyblue : .lightblue , lineWidth: 1)
                            }
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 22)
            
            Spacer()
            
            Button {
                onboardingCoordinator.push(next: .major)
            } label: {
                Text("다음")
                    .applyCertiFont(.body_semibold_16)
                    .foregroundColor(selectedtrack.isEmpty ? .grayscale400 : .white)
                    .frame(maxWidth: .infinity, minHeight: 56)
                    .background(selectedtrack.isEmpty ? .grayscale100 : .purpleblue)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .disabled(selectedtrack.isEmpty)
            .padding(.horizontal, 20)
            .padding(.bottom, 22)
        }
    }
}
