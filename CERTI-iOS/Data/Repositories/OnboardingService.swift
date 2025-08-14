//
//  OnboardingService.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/14/25.
//

import Foundation

import Moya

final class OnboardingService: BaseService, OnboardingRepository {
    
    private let provider = MoyaProvider<OnboardingAPI>.init(plugins: [MoyaPlugin()])

    func getSearchUniv(keyword: String, preSignUpToken: String) async -> Result<UnivListResponseDTO, NetworkError> {
        return await requestDecodable(provider, .searchUniv(keyword: keyword, preSignUpToken: preSignUpToken))
    }
    
    func getSearchMajor(keyword: String, preSignUpToken: String) async -> Result<MajorListResponseDTO, NetworkError> {
        return await requestDecodable(provider, .searchMajor(keyword: keyword, preSignUpToken: preSignUpToken))
    }
    
}
