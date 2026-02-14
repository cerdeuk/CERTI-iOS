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
    func addPreCertification(request: AddPreCertificationEntity) async -> Result<AppendPreCertificationStatus, NetworkError>
    func editPreCertification(request: EditPreCertificationEntity, id: Int) async -> Result<Void, NetworkError>
}
