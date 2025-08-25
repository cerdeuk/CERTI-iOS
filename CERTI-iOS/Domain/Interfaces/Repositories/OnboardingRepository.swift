//
//  OnboardingRepository.swift
//  CERTI-iOS
//
//  Created by OneTen on 8/15/25.
//


import Foundation
import Moya

protocol OnboardingRepository {
    func getSearchUniv(keyword: String, preSignUpToken: String) async -> Result<UniversityListEntity, NetworkError>
    func getSearchMajor(keyword: String, preSignUpToken: String) async -> Result<MajorListEntity, NetworkError>
}
