//
//  CertificateRepository.swift
//  CERTI-iOS
//
//  Created by 김나연 on 8/16/25.
//

protocol CertificateRepository {
    func fetchDetail(id: Int) async throws -> CertificateDetail
}
