//
//  CertificateDetailRepository.swift
//  CERTI-iOS
//
//  Created by 김나연 on 8/16/25.
//

protocol CertificateDetailRepository {
    func fetchDetail(id: Int) async throws -> CertificateDetail
    func appendPreCertification(id: Int) async throws
    func appendAcquisition(id: Int) async throws
}
