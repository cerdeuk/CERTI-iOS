//
//  HomeUsecase.swift
//  CERTI-iOS
//
//  Created by OneTen on 8/15/25.
//

import Foundation

protocol HomeUseCase {
    func getPreCertification() async -> Result<PreCertificationEntity, NetworkError>
    func deletePreCertification(id: Int) async -> Result<Void, NetworkError>
    func getFavoriteCertification() async -> Result<FavoriteCertificationEntity, NetworkError>
    func addPreCertification(certificationId: Int) async -> Result<Bool, NetworkError>
}

final class DefaultHomeUseCase: HomeUseCase {
    
    private let repository: HomeRepository

    init(repository: HomeRepository) {
        self.repository = repository
    }
    
    func getPreCertification() async -> Result<PreCertificationEntity, NetworkError> {
        let result = await repository.getPreCertification()
        return result
    }
    
    func deletePreCertification(id: Int) async -> Result<Void, NetworkError> {
        await repository.deletePreCertification(id: id)
    }
    
    func getFavoriteCertification() async -> Result<FavoriteCertificationEntity, NetworkError> {
        let result = await repository.getFavoriteCertification()
        return result
    }
    
    func addPreCertification(certificationId: Int) async -> Result<Bool, NetworkError> {
        let result = await repository.addPreCertification(certificationId: certificationId)
        return result.map { $0.data ?? false }
    }
}
