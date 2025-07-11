//
//  OnboardingCoordinator.swift
//  CERTI-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI

enum OnboardingRoute: Hashable {
    case univ
    case grade
    case track
    case major
    case jobCategory
    case info
}

final class OnboardingCoordinator: ObservableObject {
    
    //MARK: - Property Wrappers
    
    @Published var path = NavigationPath()
    
    //MARK: - Method
    
    //다음에 보여질 view를 navigationStack에 push
    func push(next route: OnboardingRoute) {
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
