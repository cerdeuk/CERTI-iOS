//
//  OnboardingRepository.swift
//  CERTI-iOS
//
//  Created by OneTen on 8/15/25.
//


import Foundation
import Moya

protocol OnboardingRepository {
    func getSearchUniv(keyword: String, preSignUpToken: String) async -> Result<UnivListResponseDTO, NetworkError>
    func getSearchMajor(keyword: String, preSignUpToken: String) async -> Result<MajorListResponseDTO, NetworkError>
}
