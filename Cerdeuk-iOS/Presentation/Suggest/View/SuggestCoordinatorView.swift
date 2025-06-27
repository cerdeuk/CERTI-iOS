//
//  SuggestCoordinatorView.swift
//  Cerdeuk-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI

struct SuggestCoordinatorView: View {
    @ObservedObject var suggestCoordinator: SuggestCoordinator
    
    var body: some View {
        NavigationStack(path: $suggestCoordinator.path) {
            SuggestView()
                .navigationDestination(for: SuggestRoute.self) { route in
                    switch route {
                    case .detail:
                        SuggestDetailView()
                    }
                }
        }
        .environmentObject(suggestCoordinator)
    }
}
