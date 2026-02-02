//
//  CertificateFactory.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/28/26.
//

import SwiftUI

protocol CertificateFactory {
    @MainActor func makeCertificateViewModel() -> CertificateViewModel
}

final class DefaultCertificateFactory: CertificateFactory {
    
    
    init(

    ) {

    }
    
    @MainActor
    func makeCertificateViewModel() -> CertificateViewModel {
        CertificateViewModel(
            
        )
    }
}

