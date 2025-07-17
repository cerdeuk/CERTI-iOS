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

    var body: some View {
        ZStack {
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
            ZStack {
                KFImage(URL(string: card.cardFrontImageUrl))
                    .retry(maxCount: 3, interval: .seconds(5))
                    .onFailure { error in
                        print("Image Failure: \(error.localizedDescription)")
                    }
                    .resizable()
                    .scaledToFill()
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(card.name)
                        .applyCertiFont(.body_bold_18)
                        .foregroundStyle(card.index == 2 ?  .lightblue : .grayscale600)
                        .frame(height: 25)
                        .padding(.leading, 20)
                    
                    Text("\(card.createdAt.toDisplayDateString())에 획득했어요.")
                        .applyCertiFont(.caption_regular_14)
                        .foregroundStyle(card.index == 2 ?  .lightblue : .grayscale600)
                        .frame(height: 20)
                        .padding(.leading, 20)
                    
                    TagChip(tags: card.tags, spacing: 4)
                        .frame(height: 23)
                        .padding(.top, 8)
                        .padding(.leading, 20)
                    
                    Spacer()
                    
                    HStack(alignment: .center, spacing: 0) {
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 0) {
                            Text("터치해서 뒷면 보기")
                                .applyCertiFont(.caption_regular_12)
                                .foregroundStyle(card.index == 2 ?  .lightblue : .mainblue)
                                .padding(.top, 4)
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
                                .frame(width: textWidth, height: 1)
                                .foregroundStyle(card.index == 2 ?  .lightblue : .mainblue)
                                .padding(.top, 4)
                        }
                        .frame(width: 90, height: 26)
                        .clipped()
                        .padding(.trailing, 15)
                        .padding(.bottom, 12)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.top, 39)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.vertical, 219)
            .padding(.horizontal, 62)
    }
    
    private var CertificateCardDetailViewBack: some View {
            ZStack{
                KFImage(URL(string: card.cardBackImageUrl))
                    .retry(maxCount: 3, interval: .seconds(5))
                    .onFailure { error in
                        print("Image Failure: \(error.localizedDescription)")
                    }
                    .resizable()
                    .scaledToFill()
                
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
                    
                    ScrollView {
                        Text("\(card.description)".antiAppleBySangyup)
                            .applyCertiFont(.caption_regular_12)
                            .foregroundStyle(.white)
                    }
                    .frame(height: 126)
                    .padding(.top, 36)
                    .padding(.bottom, 36)
                    
                    HStack(alignment: .center, spacing: 0) {
                        Image(.iconCheckWhite24)
                        Text("서티님의 취득일자")
                            .applyCertiFont(.caption_semibold_14)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.bottom, 4)
                    
                    Text(card.createdAt.toDisplayDateString())
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
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.vertical, 219)
            .padding(.horizontal, 62)
        }
}
