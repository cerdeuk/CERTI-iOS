//
//  AppCoordinator.swift
//  CERTI-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI

enum AppRoute {
    case onboarding
    case auth
    case main
}

final class AppCoordinator: ObservableObject {
    
    // MARK: - Properties
    
    @Published var appState: AppRoute = .main
    @Published var tabCoordinator = CDTabCoordinator()
    
    //MARK: - Method
    
    func switchAppState(state: AppRoute) {
        appState = state
    }
}
