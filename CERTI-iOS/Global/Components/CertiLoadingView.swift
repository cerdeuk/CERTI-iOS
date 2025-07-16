//
//  CertiLoadingView.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/16/25.
//

import SwiftUI

struct CertiLoadingView: View {
    @State private var offset: CGFloat = 0

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    
                    ZStack {
                        HStack(spacing: 23) {
                            Image(.loadingBackground)
                            Image(.loadingBackground)
                            Image(.loadingBackground)
                            Image(.loadingBackground)
                        }
                        .offset(x: offset)
                        .onAppear {
                            let totalWidth = geometry.size.width/2
                            withAnimation(
                                Animation.linear(duration: 3).repeatForever(autoreverses: false)
                            ) {
                                offset = -totalWidth
                            }
                        }
                        .frame(width: 170)
                        .clipped()

                        Image(.loading)
                    }
                    
                    Spacer()
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
        }
    }
}
#Preview {
    CertiLoadingView()
}
