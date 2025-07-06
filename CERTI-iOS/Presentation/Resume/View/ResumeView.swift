//
//  ResumeView.swift
//  CERTI-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI

struct ResumeView: View {
    @EnvironmentObject var resumeCoordinator: ResumeCoordinator

    var body: some View {
        VStack {
            Text("이력서 화면")
            Button("디테일 보기") {
                resumeCoordinator.push(next: .detail)
            }
        }
    }
}

#Preview {
    ResumeView()
}
