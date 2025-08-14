//
//  HomeRepository.swift
//  CERTI-iOS
//
//  Created by OneTen on 8/15/25.
//

import Foundation

protocol HomeRepository {
    func getPreCertification() async -> Result<PreCertificationInfoResponseDTO, NetworkError>
    func deletePreCertification(id: Int) async -> Result<Void, NetworkError>
    func getFavoriteCertification() async -> Result<FavoriteCertificationResponseDTO, NetworkError>
    func addPreCertification(certificationId: Int) async -> Result<BaseResponseDTO<Bool>, NetworkError>
}
