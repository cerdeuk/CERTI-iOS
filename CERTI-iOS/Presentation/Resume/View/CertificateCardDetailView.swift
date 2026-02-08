//
//  CertificateCardDetailView.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/8/25.
//

import SwiftUI

import Kingfisher

struct CertificateCardDetailView: View {
    let card: CertificatedDetailModel
    @State private var rotation: Double = 0
    @State var isFlipped = false
    @State private var textWidth: CGFloat = 0
    @State private var isImageLoaded = false
    
    var body: some View {
        ZStack(alignment: .center) {
            CertificateCardDetailViewFront
                .opacity(rotation > 90 ? 0 : 1)
                .rotation3DEffect(
                    .degrees(rotation),
                    axis: (x: 0, y: 1, z: 0)
                )
            
            CertificateCardDetailViewBack
                .opacity(rotation > 90 ? 1 : 0)
                .rotation3DEffect(
                    .degrees(rotation + 180),
                    axis: (x: 0, y: 1, z: 0)
                )
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.4)) {
                if isFlipped {
                    rotation = 0
                } else {
                    rotation = 180
                }
                isFlipped.toggle()
            }
        }
    }
}

extension CertificateCardDetailView {
    private var CertificateCardDetailViewFront: some View {
        ZStack(alignment: .center) {
            KFImage(URL(string: card.cardFrontImageUrl))
                .onSuccess { _ in
                    isImageLoaded = true
                }
                .placeholder {
                    Color.blackOpacity40
                        .frame(width: 250, height: 375)
                }
                .retry(maxCount: 3, interval: .seconds(5))
                .onFailure { error in
                    print("Image Failure: \(error.localizedDescription)")
                }
                .resizable()
                .scaledToFit()
            
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .center, spacing: 0) {
                    Spacer()
                    
                    Text("획득 날짜: \(card.acquisitionDate.toUIDateString())")
                        .applyCertiFont(.caption_regular_10)
                        .foregroundStyle(.white)
                    
                    Spacer()
                }
                .frame(height: 15)
                
                Text(card.name)
                    .applyCertiFont(.caption_bold_14)
                    .foregroundStyle(.bluewhite)
                    .frame(height: 20)
                    .padding(.top, 163)
                    .padding(.leading, 28)
                
                TagChipColor(tags: card.tags, fontStyle: .caption_regular_10, spacing: 6, cornerRadius: 8, backgroundColor: .white, textColor: .mainblue)
                    .frame(height: 19)
                    .padding(.top, 6)
                    .padding(.leading, 28)
                
                HStack(alignment: .center, spacing: 0) {
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("터치해서 뒷면 보기")
                            .applyCertiFont(.caption_semibold_10)
                            .foregroundStyle(.purplewhite)
                            .padding(.top, 13)
                            .background(
                                GeometryReader { geometry in
                                    Color.clear
                                        .onAppear {
                                            textWidth = geometry.size.width
                                        }
                                        .onChange(of: geometry.size.width) { newWidth in
                                            textWidth = newWidth
                                        }
                                }
                            )
                        
                        Rectangle()
                            .frame(width: textWidth, height: 0.7)
                            .foregroundStyle(.purplewhite)
                            .padding(.top, 2)
                    }
                    
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(.top, 77)
        }
        .frame(maxWidth: 250, maxHeight: 375)
        .padding(.vertical, 219)
        .padding(.horizontal, 62)
        
    }
    
    private var CertificateCardDetailViewBack: some View {
        ZStack(alignment: .center) {
            KFImage(URL(string: card.cardBackImageUrl))
                .retry(maxCount: 3, interval: .seconds(5))
                .onFailure { error in
                    print("Image Failure: \(error.localizedDescription)")
                }
                .resizable()
                .scaledToFit()
            
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .center, spacing: 0) {
                    Text(card.name)
                        .applyCertiFont(.body_bold_18)
                        .foregroundStyle(.white)
                        .fixedSize(horizontal: true, vertical: false)
                        .lineLimit(1)
                    
                    Spacer()
                }
                
                TagChip(tags: card.tags, spacing: 8)
                    .frame(height: 23)
                    .padding(.top, 8)
                
                Spacer()
                
                ScrollView {
                    Text("\(card.description)".antiAppleBySangyup)
                        .applyCertiFont(.caption_regular_12)
                        .foregroundStyle(.white)
                }
                .scrollIndicators(.hidden)
                .frame(minHeight: 126)
                .padding(.top, 36)
                .padding(.bottom, 36)
                
                Spacer()
                
                HStack(alignment: .center, spacing: 0) {
                    Image(.iconCheckWhite24)
                    Text("\(AuthManager.shared.nickname.trimmedUsername())님의 취득일자")
                        .applyCertiFont(.caption_semibold_14)
                        .foregroundColor(.white)
                    Spacer()
                }
                .frame(height: 24)
                .padding(.bottom, 4)
                
                Text(card.acquisitionDate.toDisplayDateString())
                    .applyCertiFont(.caption_semibold_14)
                    .foregroundStyle(.purpleblue)
                    .frame(height: 20)
                    .padding(.vertical, 4.5)
                    .padding(.horizontal, 12)
                    .background(.grayscale0)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.bottom, 31)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(.top, 30)
            .padding(.horizontal, 24)
        }
        .frame(maxWidth: 250, maxHeight: 375)
        .padding(.vertical, 219)
        .padding(.horizontal, 62)
    }
}
