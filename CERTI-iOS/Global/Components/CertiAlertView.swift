//
//  CertiAlertView.swift
//  CERTI-iOS
//
//  Created by OneTen on 11/2/25.
//

import SwiftUI

struct CertiAlertView: View {
    
    enum AlertStyle {
        case plain
        case withdraw
        case onlyTitle
    }
    
    //MARK: - Property Wrappers

    @State private var isProcessing: Bool = false
    @State private var hasConfirmed: Bool = false
    
    //MARK: - Properties

    let style: AlertStyle
    let onConfirm: () async -> Void
    let onCancel: () -> Void
    let titleMessage: String
    var subTitleMessage: String? = nil
    let confirmText: String
    let cancelText: String
    
    var confirmColor: Color {
        switch style {
        case .plain, .onlyTitle:
            return .mainblue
        case .withdraw:
            return .error
        }
    }
    
    var titleFont: CertiFont {
        switch style {
        case .plain, .withdraw:
            return .body_semibold_18
        case .onlyTitle:
            return .body_semibold_16
        }
    }
    
    //MARK: - Main Body

    var body: some View {
        ZStack {
            Color.blackOpacity40
            
            VStack(alignment: .center, spacing: 0) {

                Text(titleMessage)
                    .applyCertiFont(titleFont)
                    .foregroundStyle(.grayscale600)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 16)
                    .padding(.top, 25)
                    .padding(.horizontal, 40)
                
                if subTitleMessage != nil {
                    Text(subTitleMessage!)
                        .applyCertiFont(.caption_regular_14)
                        .foregroundStyle(.grayscale600)
                        .padding(.horizontal, 35)
                        .padding(.bottom, 25)
                }
                
                Color.grayscale100
                    .frame(height: 1)
                
                HStack(alignment: .center, spacing: 0) {
                    Button {
                        if !isProcessing {
                            onCancel()
                        }
                    } label: {
                        Text(cancelText)
                            .applyCertiFont(.body_semibold_18)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .foregroundStyle(.black)
                    }
                    .disabled(isProcessing)
                    
                    Color.grayscale100
                        .frame(width: 1)
                    
                    Button{
                        confirmOnce()
                    } label: {
                        Text(confirmText)
                            .applyCertiFont(.body_semibold_18)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .foregroundStyle(confirmColor)
                    }
                    .disabled(isProcessing)
                    
                }
                .frame(height: 58)
                
            }
            .frame(maxWidth: .infinity)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal, 20)

        }
        .ignoresSafeArea()
    }
}

//MARK: - Private Func

extension CertiAlertView {
    private func confirmOnce() {
        guard !isProcessing && !hasConfirmed else { return }
        isProcessing = true
        hasConfirmed = true

        Task {
            await onConfirm()
            isProcessing = false
        }
    }
}

#Preview {
    ZStack {
        Color.gray
            .zIndex(1)

        CertiAlertView(
            style: .plain,
            onConfirm: { },
            onCancel: { },
            titleMessage: "로그아웃하시겠습니까?",
            subTitleMessage: "로그아웃 시 재로그인이 필요합니다.",
            confirmText: "예",
            cancelText: "아니요"
        )
        .zIndex(2)
    }
}
