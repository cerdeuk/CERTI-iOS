//
//  RecommendCompleteModalView.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/13/25.
//

import SwiftUI

struct RecommendCompleteModalView: View {
    @EnvironmentObject var tabRouter: CertiTabCoordinator
    let certificationName: String
    
    var body: some View {
        ZStack {
            Color.blackOpacity40
            
            VStack(alignment: .center, spacing: 0) {
                Text("자격증 취득 완료")
                    .applyCertiFont(.body_bold_18)
                    .foregroundStyle(.grayscale600)
                    .frame(height: 25)
                    .padding(.top, 40)
                
                Text(certificationName)
                    .applyCertiFont(.caption_semibold_14)
                    .foregroundStyle(.grayscale400)
                    .frame(height: 20)
                    .padding(.top, 12)
                
                Image(.imageCertificationCardGet)
                    .padding(.top, 4)
                
                Button {
                    tabRouter.switchTab(tab: .resume)
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundStyle(.grayscale500)
                            .frame(height: 42)
                        
                        Text("캐릭터 카드 보러가기")
                            .applyCertiFont(.caption_semibold_14)
                            .foregroundStyle(.white)
                            .frame(height: 20)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 8)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 360)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal, 62.5)
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    RecommendCompleteModalView(certificationName: "싱이싱이원싱이")
}
