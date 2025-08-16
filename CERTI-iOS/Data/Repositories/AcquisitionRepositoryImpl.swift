//
//  AcquisitionRepositoryImpl.swift
//  CERTI-iOS
//
//  Created by 김나연 on 8/16/25.
//

import Foundation

enum AppendAcquisitionError: LocalizedError, Equatable {
    case duplicationError
}

final class AcquisitionRepositoryImpl: AcquisitionRepository {
    
    private let acquisitionService: AcquisitionServiceProtocol

    init(acquisitionService: AcquisitionServiceProtocol) {
        self.acquisitionService = acquisitionService
    }
    
    func appendAcquisition(id: Int) async throws {
        let result = await acquisitionService.addAcquisition(certificationId: id)

        switch result {
        case .success(let response):
            guard let ok = response.data else {
                throw NetworkError.decodingError
            }
            if ok { return } else {
                throw AppendAcquisitionError.duplicationError
            }
        case .failure(let error):
            throw error
        }
    }
}
