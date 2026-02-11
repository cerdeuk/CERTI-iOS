//
//  CertificateCoordinator.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/28/26.
//

import SwiftUI

enum CertificateRoute: Hashable {
    case search // 검색
    case certificateDetail  // 자격증 클릭 시 디테일뷰
    case trackList  // 계열별 자격증
    case jobList    // 직무별 자격증
}

final class CertificateCoordinator: ObservableObject {
    
    //MARK: - Property Wrappers
    
    @Published var path = NavigationPath()
    
    //MARK: - Method
    
    //다음에 보여질 view를 navigationStack에 push
    func push(next route: CertificateRoute) {
        path.append(route)
    }
    
    //현재 view를 navigationStack에서 pop
    func pop() {
        path.removeLast()
    }
    
    //맨 처음으로 돌아감(navigationStack 초기화)
    func reset() {
        path = NavigationPath()
    }
}

