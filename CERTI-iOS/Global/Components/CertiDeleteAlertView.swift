//
//  CertiDeleteAlertView.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/7/25.
//

import SwiftUI

struct CertiDeleteAlertView: View {
    
    //MARK: - Property Wrappers

    @State private var isProcessing: Bool = false
    @State private var hasConfirmed: Bool = false
    
    //MARK: - Properties

    let onConfirm: () async -> Void
    let onCancel: () -> Void
    
    //MARK: - Main Body

    var body: some View {
        ZStack {
            Color.blackOpacity40
            
            VStack(alignment: .center, spacing: 0) {
                Spacer()

                Text("삭제하시겠습니까?")
                    .applyCertiFont(.body_semibold_18)
                    .foregroundStyle(.grayscale600)
                    .frame(height: 25)
                    .padding(.bottom, 16)
                
                Text("삭제하게 되면 복구할 수 없어요.")
                    .applyCertiFont(.caption_regular_14)
                    .foregroundStyle(.grayscale600)
                    .frame(height: 20)
                
                Spacer()
                
                Color.grayscale100
                    .frame(height: 1)
                
                HStack(alignment: .center, spacing: 0) {
                    Button {
                        if !isProcessing {
                            onCancel()
                        }
                    } label: {
                        Text("취소")
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
                        Text("확인")
                            .applyCertiFont(.body_semibold_18)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .foregroundStyle(.mainblue)
                    }
                    .disabled(isProcessing)
                    
                }
                .frame(height: 58)
                
            }
            .frame(maxWidth: .infinity)
            .frame(height: 178)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal, 20)

        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

//MARK: - Private Func

extension CertiDeleteAlertView {
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
