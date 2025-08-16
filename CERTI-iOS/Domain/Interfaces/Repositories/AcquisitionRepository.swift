//
//  AcquisitionRepository.swift
//  CERTI-iOS
//
//  Created by 김나연 on 8/16/25.
//

protocol AcquisitionRepository {
    func appendAcquisition(id: Int) async throws
}
