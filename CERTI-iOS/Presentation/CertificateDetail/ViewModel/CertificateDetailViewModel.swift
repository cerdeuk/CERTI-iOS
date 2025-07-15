//
//  CertificateDetailViewModel.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/16/25.
//

import SwiftUI

class CertificateDetailViewModel: ObservableObject {
    @Published var certificateDetail: CertificateDetailModel = CertificateDetailModel.dummy()
}
