//
//  HomeService.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/16/25.
//

import Foundation

import Moya

protocol HomeServiceProtocol {
    func getPreCertification() async -> Result<PreCertificationInfoResponseDTO, NetworkError>
    func deletePreCertification(id: Int) async -> Result<Void, NetworkError>
    func getFavoriteCertification() async -> Result<FavoriteCertificationResponseDTO, NetworkError>
    func addPreCertification(certificationId: Int) async -> Result<BaseResponseDTO<Bool>, NetworkError>
    func getMonthlyPreCertification(year: Int, month: Int) async -> Result<MonthlyPreCertificationResponseDTO, NetworkError>
    func getDailyPreCertification(date: String) async -> Result<DailyPreCertificationResponseDTO, NetworkError>
}

final class HomeService: BaseService, HomeServiceProtocol {
            
    private let provider = MoyaProvider<HomeAPI>.init(plugins: [MoyaPlugin()])

    func getPreCertification() async -> Result<PreCertificationInfoResponseDTO, NetworkError> {
        return await requestDecodable(provider, .getPreCertification)
    }
    
    func deletePreCertification(id: Int) async -> Result<Void, NetworkError> {
        return await requestVoid(provider, .deletePreCertification(id: id))
    }
    
    func getFavoriteCertification() async -> Result<FavoriteCertificationResponseDTO, NetworkError> {
        return await requestDecodable(provider, .getFavoriteCertification)
    }

    func addPreCertification(certificationId: Int) async -> Result<BaseResponseDTO<Bool>, NetworkError> {
        return await requestDecodable(provider, .addPreCertification(certificationId: certificationId))
    }
    
    func getMonthlyPreCertification(year: Int, month: Int) async -> Result<MonthlyPreCertificationResponseDTO, NetworkError> {
        return await requestDecodable(provider, .getMonthlyPreCertification(year: year, month: month))
    }
    
    func getDailyPreCertification(date: String) async -> Result<DailyPreCertificationResponseDTO, NetworkError> {
        return await requestDecodable(provider, .getDailyPreCertification(date: date))
    }
}
