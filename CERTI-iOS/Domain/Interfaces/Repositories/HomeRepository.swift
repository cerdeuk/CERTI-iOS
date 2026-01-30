//
//  HomeRepository.swift
//  CERTI-iOS
//
//  Created by OneTen on 8/15/25.
//

import Foundation

protocol HomeRepository {
    func getPreCertification() async -> Result<PreCertificationEntity, NetworkError>
    func deletePreCertification(id: Int) async -> Result<Void, NetworkError>
    func getFavoriteCertification() async -> Result<FavoriteCertificationEntity, NetworkError>
    func addPreCertification(certificationId: Int) async -> Result<AppendPreCertificationStatus, NetworkError>
    func getMonthlyPreCertification(year: Int, month: Int) async -> Result<MonthlyPreCertificationEntity, NetworkError>
    func getDailyPreCertification(date: String) async -> Result<DailyPreCertificationEntity, NetworkError>
}
