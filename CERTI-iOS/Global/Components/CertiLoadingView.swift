//
//  CertiLoadingView.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/16/25.
//

import SwiftUI

import Lottie

struct CertiLoadingView: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                
                Image(.loading)
                
                Spacer()
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
    }
}

#Preview {
    CertiLoadingView()
}
