//
//  DefaultOnboardingRepository.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/14/25.
//

import Foundation

import Moya

final class DefaultOnboardingRepository: BaseService<OnboardingAPI>, OnboardingRepository {
    
    func getSearchUniv(keyword: String, preSignUpToken: String) async -> Result<UnivListResponseDTO, NetworkError> {
        return await requestDecodable(.searchUniv(keyword: keyword, preSignUpToken: preSignUpToken))
    }
    
    func getSearchMajor(keyword: String, preSignUpToken: String) async -> Result<MajorListResponseDTO, NetworkError> {
        return await requestDecodable(.searchMajor(keyword: keyword, preSignUpToken: preSignUpToken))
    }
    
}
