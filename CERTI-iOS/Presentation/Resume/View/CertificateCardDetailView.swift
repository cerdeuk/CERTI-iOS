//
//  CertificateCardDetailView.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/8/25.
//

import SwiftUI

struct CertificateCardDetailView: View {
    @ObservedObject var viewModel : ResumeViewModel
    @State private var rotation: Double = 0
    @State var isFlipped = false

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
                Image(.imageCertificationCardLarge1)
                    .resizable()
                    .scaledToFill()
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(viewModel.certificatedDummy.first!.name)
                        .applyCertiFont(.body_bold_18)
                        .foregroundStyle(.grayscale600)
                        .frame(height: 25)
                        .padding(.leading, 20)
                    
                    Text(viewModel.certificatedDummy.first!.displayCreatedAt)
                        .applyCertiFont(.caption_regular_14)
                        .foregroundStyle(.grayscale600)
                        .frame(height: 20)
                        .padding(.leading, 20)
                    
                    TagChip(tags: viewModel.certificatedDummy.first!.tags, spacing: 4)
                        .padding(.top, 8)
                        .frame(height: 23)
                        .padding(.leading, 20)
                    
                    Spacer()
                    
                    HStack(alignment: .center, spacing: 0) {
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 0) {
                            Text("터치해서 뒷면 보기")
                                .applyCertiFont(.caption_regular_12)
                                .foregroundStyle(.mainblue)
                                .frame(height: 18)
                            
                            Rectangle()
                                .frame(width: 90, height: 1)
                                .foregroundStyle(.mainblue)
                                .padding(.top, 4)
                        }
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
                Image(.imageCertificationCardLarge1Back)
                    .resizable()
                    .scaledToFill()
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack(alignment: .center, spacing: 0) {
                        Text(viewModel.certificatedDummy.first!.name)
                            .applyCertiFont(.body_bold_18)
                            .foregroundStyle(.white)
                            .fixedSize(horizontal: true, vertical: false)
                            .lineLimit(1)
                        
                        Spacer()
                    }
                    
                    TagChip(tags: viewModel.certificatedDummy.first!.tags, spacing: 8)
                        .frame(height: 23)
                        .padding(.top, 8)
                    
                    Text("\(viewModel.certificatedDummy.first!.description)".antiAppleBySangyup)
                        .applyCertiFont(.caption_regular_12)
                        .foregroundStyle(.white)
                        .padding(.top, 36)
                    
                    Spacer()
                    
                    HStack(alignment: .center, spacing: 0) {
                        Image(.iconCheckWhite24)
                        Text("서티님의 취득일자")
                            .applyCertiFont(.caption_semibold_14)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.bottom, 4)
                    
                    Text(viewModel.certificatedDummy.first!.displayCreatedAt)
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
