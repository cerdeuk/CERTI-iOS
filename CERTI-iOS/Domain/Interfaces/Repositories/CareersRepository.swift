//
//  CareersRepository.swift
//  CERTI-iOS
//
//  Created by OneTen on 8/15/25.
//


import Foundation
import Moya

protocol CareersRepository {
    func fetchCareersList() async -> Result<CareerListEntity, NetworkError>
    func deleteCareers(id: Int) async -> Result<Void, NetworkError>
    func addCareer(request: CareerEntity) async -> Result<Void, NetworkError>
    func editCareer(careerId:Int, request: CareerEntity) async -> Result<Void, NetworkError>
}
