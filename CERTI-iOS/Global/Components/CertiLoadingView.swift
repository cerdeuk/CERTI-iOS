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

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                HStack {
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
    CertiLoadingView()
}
