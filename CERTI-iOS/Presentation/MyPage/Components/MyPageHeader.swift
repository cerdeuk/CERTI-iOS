//
//  MyPageHeader.swift
//  CERTI-iOS
//
//  Created by OneTen on 11/21/25.
//

import SwiftUI

struct MyPageHeader: View {
    enum MyPageHeaderStyle {
        case normal
        case save
        case noneTitle
    }
    
    let style: MyPageHeaderStyle
    let title: String?
    var isActionEnabled: Bool = true
    let action: () -> Void?
    let backButtonAction: () -> Void
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Button {
                backButtonAction()
            } label: {
                Image(.iconArrowleft36)
            }
            
            Spacer()
            
            if style != .noneTitle {
                Text(title ?? "")
                    .applyCertiFont(.sub_semibold_20)
                    .foregroundStyle(.grayscale600)
                    .frame(height: 25)
            }
            
            Spacer()
            
            switch style {
            case .normal, .noneTitle:
                Rectangle()
                    .foregroundStyle(.clear)
                    .frame(width: 36)
            case .save:
                Button {
                    action()
                } label: {
                    Text("저장")
                        .applyCertiFont(.body_semibold_18)
                        .foregroundStyle(isActionEnabled ? .mainblue : .grayscale400)
                        .frame(width: 36, height: 25)
                }
                .disabled(!isActionEnabled)
            }
        }
        .padding(.horizontal, 20)
        .frame(height: 68)
    }
}
