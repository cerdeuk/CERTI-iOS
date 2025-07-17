//
//  CertiLoadingView.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/16/25.
//

import SwiftUI

struct CertiLoadingView: View {
    @State private var offset: CGFloat = 0
    @State var isAnimating: Bool = false
    
    let name: String
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 0) {
                Spacer()
                HStack(alignment: .center, spacing: 0) {
                    Spacer()
                    
                    ZStack(alignment: .center) {
                        HStack(spacing: 23) {
                            Image(.loadingBackground)
                            Image(.loadingBackground)
                            Image(.loadingBackground)
                            Image(.loadingBackground)
                        }
                        .offset(x: offset)
                        .onAppear {
                            let totalWidth = CGFloat(integerLiteral: 185)
                            withAnimation(
                                Animation.linear(duration: 3).repeatForever(autoreverses: false)
                            ) {
                                offset = -totalWidth
                            }
                        }
                        .frame(width: 170)
                        .clipped()

                        Image(.loading)
                            .offset(y: isAnimating ? 0 : -10)
                            .animation(.easeInOut.repeatForever().speed(0.3), value: isAnimating)
                    }
                    
                    Spacer()
                }
                .padding(.bottom, 20)
                
                Text("\(Text.trimmedUsername(name))님에게 딱 맞는\n자격증을 고르고 있어요.")
                    .applyCertiFont(.body_semibold_16)
                    .foregroundStyle(.grayscale600)
                    .multilineTextAlignment(.center)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
            .onAppear {
                isAnimating = true
            }
        }
    }
}
#Preview {
    CertiLoadingView(name: "김서티222")
}
