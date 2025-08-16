//
//  HomeRepositoryImpl.swift
//  CERTI-iOS
//
//  Created by 김나연 on 8/16/25.
//

import Foundation

enum AppendPreCertificationError: LocalizedError, Equatable {
    case duplicationError
    case conflictError
}

final class HomeRepositoryImpl: HomeRepository {
    
    private let homeService: HomeServiceProtocol
    
    init(homeService: HomeServiceProtocol) {
        self.homeService = homeService
    }
    
    func appendPreCertification(id: Int) async throws {
        let result = await homeService.addPreCertification(certificationId: id)

        switch result {
        case .success(let response):
            if response.status == 409 {
                throw AppendPreCertificationError.conflictError
            }
            guard let ok = response.data else {
                throw NetworkError.decodingError
            }
            if ok { return } else {
                throw AppendPreCertificationError.duplicationError
            }
            
        case .failure(let error):
            throw error
        }
    }
}
