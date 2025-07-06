//
//  HomeDetailView.swift
//  CERTI-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI

struct HomeDetailView: View {
    @EnvironmentObject var tabRouter: CertiTabCoordinator

    @State private var isDeleteAlertPresented = false

    var body: some View {
        ZStack {
            VStack {
                Button {
                    isDeleteAlertPresented = true
                } label: {
                    Text("삭제 알림 버튼 띄우기")
                }
            }
            
            if isDeleteAlertPresented {
                CertiDeleteAlertView {
                    isDeleteAlertPresented = false
                    print("확인 버튼 클릭")
                } onCancel: {
                    isDeleteAlertPresented = false
                    print("취소버튼 클릭")
                }

            }
        }
    }
}
