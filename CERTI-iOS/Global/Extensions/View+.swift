//
//  View+.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/5/25.
//

import SwiftUI

extension View {
    func applyCertiFont(_ style: CertiFont) -> some View {
        self.modifier(ApplyCertiFontModifier(style: style))
    }
    
    //커서 까맣게
    func blackCursor() -> some View {
        self.tint(.black)
    }
    
    //키보드 닫히게
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
