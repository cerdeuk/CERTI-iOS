//
//  DefaultHomeRepository.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/16/25.
//

import Foundation

import Moya

final class DefaultHomeRepository: BaseService<HomeAPI>, HomeRepository {
            
    func getPreCertification() async -> Result<PreCertificationInfoResponseDTO, NetworkError> {
        return await requestDecodable(.getPreCertification)
    }
    
    func deletePreCertification(id: Int) async -> Result<Void, NetworkError> {
        return await requestVoid(.deletePreCertification(id: id))
    }
    
    func getFavoriteCertification() async -> Result<FavoriteCertificationResponseDTO, NetworkError> {
        return await requestDecodable(.getFavoriteCertification)
    }

    func addPreCertification(certificationId: Int) async -> Result<BaseResponseDTO<Bool>, NetworkError> {
        return await requestDecodable(.addPreCertification(certificationId: certificationId))
    }
}
