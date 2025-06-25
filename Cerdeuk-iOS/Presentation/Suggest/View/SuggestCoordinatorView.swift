//
//  SuggestCoordinatorView.swift
//  Cerdeuk-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI

struct SuggestCoordinatorView: View {
    @ObservedObject var coordinator: SuggestCoordinator
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            SuggestView()
                .navigationDestination(for: SuggestRoute.self) { route in
                    switch route {
                    case .detail:
                        SuggestDetailView()
                    }
                }
        }
        .environmentObject(coordinator)

    }
}
