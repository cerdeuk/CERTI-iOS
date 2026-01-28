//
//  CertificateViewModel.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/28/26.
//

import Foundation

enum CertificateViewRoute {
    case navigateToSearch
    case navigateToCertificateDetail
    case navigateTotrackList  // 계열별 자격증
    case navigateTojobList    // 직무별 자격증
    
    case certificateViewRoutePop
}

@MainActor
final class CertificateViewModel: ObservableObject {
    @Published var certificateViewRoute: CertificateViewRoute?

}


// MARK: - Navigation Func

extension CertificateViewModel {
    
    func navigateToSearch() {
        certificateViewRoute = .navigateToSearch
    }
    
    func navigateToCertificateDetail() {
        certificateViewRoute = .navigateToCertificateDetail
    }
    
    func navigateTotrackList() {
        certificateViewRoute = .navigateTotrackList
    }
    
    func navigateTojobList() {
        certificateViewRoute = .navigateTojobList
    }
    
    func certificateViewRoutePop() {
        certificateViewRoute = .certificateViewRoutePop
    }
}
