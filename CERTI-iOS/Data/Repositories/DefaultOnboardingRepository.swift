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
    
    func getSearchUniv(keyword: String, preSignUpToken: String) async -> Result<UnivListResponseDTO, NetworkError> {
        return await service.getSearchUniv(keyword: keyword, preSignUpToken: preSignUpToken)
    }
    
    func getSearchMajor(keyword: String, preSignUpToken: String) async -> Result<MajorListResponseDTO, NetworkError> {
        return await service.getSearchMajor(keyword: keyword, preSignUpToken: preSignUpToken)
    }
    
}
