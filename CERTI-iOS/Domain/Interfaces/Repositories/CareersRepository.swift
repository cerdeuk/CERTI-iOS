//
//  CareersRepository.swift
//  CERTI-iOS
//
//  Created by OneTen on 8/15/25.
//


import Foundation
import Moya

protocol CareersRepository {
    func fetchCareersList() async -> Result<CareersListEntity, NetworkError>
    func deleteCareers(id: Int) async -> Result<Void, NetworkError>
    func addCareer(request: CareersEntity) async -> Result<Bool, NetworkError>
    func editCareer(request: CareersEntity) async -> Result<Bool, NetworkError>
}
