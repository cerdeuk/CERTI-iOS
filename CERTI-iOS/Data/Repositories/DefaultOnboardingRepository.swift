//
//  DefaultOnboardingRepository.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/14/25.
//

import Foundation

import Moya

final class DefaultOnboardingRepository: OnboardingRepository {
    
    private let service: OnboardingServiceProtocol

    public init(service: OnboardingServiceProtocol) {
        self.service = service
    }
    
    func getSearchUniv(keyword: String, preSignUpToken: String) async -> Result<UniversityListEntity, NetworkError> {
        let result = await service.getSearchUniv(keyword: keyword, preSignUpToken: preSignUpToken)
        
        switch result {
        case .success(let dto):
            guard let entity = dto.data?.toEntity() else {
                return .failure(.decodingError)
            }
            return .success(entity)
        case .failure(let error):
            return .failure(error)
        }
        
    }
    
    func getSearchMajor(keyword: String, preSignUpToken: String) async -> Result<MajorListEntity, NetworkError> {
        let result = await service.getSearchMajor(keyword: keyword, preSignUpToken: preSignUpToken)
        
        switch result {
        case .success(let dto):
            guard let entity = dto.data?.toEntity() else {
                return .failure(.decodingError)
            }
            return .success(entity)
        case .failure(let error):
            return .failure(error)
        }
        
    }
    
}
