//
//  ApplyCertiFontModifier.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/5/25.
//

import SwiftUI

struct ApplyCertiFontModifier: ViewModifier {
    let style: CertiFont

    func body(content: Content) -> some View {
        content
            .font(style.font)
            .lineSpacing(style.fontSize * (style.lineHeight - 1))
            .kerning(style.letterSpacing * style.fontSize)
    }
}
