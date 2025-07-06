//
//  TextEditor+.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/6/25.
//

import SwiftUI

extension TextEditor {
    
    ///글자 수 제한
    func maxLength(_ length: Int, text: Binding<String>) -> some View {
        self
            .onChange(of: text.wrappedValue) { newValue in
                if newValue.count > length {
                    text.wrappedValue = String(newValue.prefix(length))
                }
            }
    }
}
