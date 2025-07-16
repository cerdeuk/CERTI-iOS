//
//  LoadingViewManager.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/16/25.
//

import Foundation

@MainActor
final class LoadingViewManager: ObservableObject {
    @Published var isLoadingNetwork: Bool = true
    
    private var loadingCount = 0 {
        didSet {
            self.isLoadingNetwork = self.loadingCount > 0
        }
    }

    func startLoading() {
        loadingCount += 1
    }

    func stopLoading() {
        loadingCount = max(loadingCount - 1, 0)
    }
}
