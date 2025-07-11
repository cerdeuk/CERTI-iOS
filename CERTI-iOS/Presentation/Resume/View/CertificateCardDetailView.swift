//
//  CertificateCardDetailView.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/8/25.
//

import SwiftUI

struct CertificateCardDetailView: View {
    @State private var isFlipped = false
    @State private var rotation: Double = 0
    
    var body: some View {
        ZStack {
            CardFront()
                .opacity(rotation > 90 ? 0 : 1)
                .rotation3DEffect(
                    .degrees(rotation),
                    axis: (x: 0, y: 1, z: 0)
                )
            
            CardBack()
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

private struct CardFront: View {
    var cardImageFront: String = ""
    var name: String = ""
    var date: String = ""
    var certiTag: [String] = ["디자인", "컴퓨터"]
    
    var body: some View {
        ZStack {
            Image(.imageCertificationCardLarge1)
                .resizable()
                .scaledToFill()
            
            VStack(alignment: .leading, spacing: 0) {
                Text("GTQ 1급 (그래픽기술자격)")
                    .applyCertiFont(.body_bold_18)
                    .foregroundStyle(.grayscale600)
                    .frame(height: 25)
                    .padding(.leading, 20)
                
                Text("2025년 7월 5일에 획득했어요.")
                    .applyCertiFont(.caption_regular_14)
                    .foregroundStyle(.grayscale600)
                    .frame(height: 20)
                    .padding(.leading, 20)
                
                TagChip(tags: certiTag, spacing: 4)
                    .padding(.top, 8)
                    .frame(height: 23)
                    .padding(.leading, 20)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    VStack(spacing: 0) {
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
}

private struct CardBack: View {
    var cardImageBack: String = ""
    var name: String = ""
    var date: String = ""
    var detail: String = ""
    var certiTag: [String] = ["디자인", "컴퓨터"]
    
    var body: some View {
        ZStack{
            Image(.imageCertificationCardLarge1Back)
                .resizable()
                .scaledToFill()
            
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text("GTQ 1급 (그래픽기술자격)")
                        .applyCertiFont(.body_bold_18)
                        .foregroundStyle(.white)
                        .fixedSize(horizontal: true, vertical: false)
                        .lineLimit(1)
                    
                    Spacer()
                }
                
                TagChip(tags: certiTag, spacing: 8)
                    .frame(height: 23)
                    .padding(.top, 8)
                
                Text("2D 그래픽 툴의 기능을 활용한 사고의 시각화를 통해 이미지 제작, 수정, 편집 및 그래픽 디자인을 창출하는 업무를 수행하고 이를 통해 비지니스 커뮤니케이션을 원활하게 한다. 1급과 2급, 급수의 차이는 이 업무를 수행하는 툴 활용 능력의 범위와 숙련도 등의 고도화 차이이다.".antiAppleBySangyup)
                    .applyCertiFont(.caption_regular_12)
                    .foregroundStyle(.white)
                    .padding(.top, 36)
                
                HStack(spacing: 0) {
                    Image(.iconCheckWhite24)
                    Text("서티님의 취득일자")
                        .applyCertiFont(.caption_semibold_14)
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.top, 36)
                
                Text("2025년 7월 10일")
                    .applyCertiFont(.caption_semibold_14)
                    .foregroundStyle(.purpleblue)
                    .frame(height: 20)
                    .padding(.vertical, 4.5)
                    .padding(.horizontal, 12)
                    .background(.grayscale0)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.top, 4)
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

#Preview {
    CertificateCardDetailView()
}
