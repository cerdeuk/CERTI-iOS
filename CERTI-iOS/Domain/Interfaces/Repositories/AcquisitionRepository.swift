//
//  AcquisitionRepository.swift
//  CERTI-iOS
//
//  Created by OneTen on 8/15/25.
//


import Foundation
import Moya

protocol AcquisitionRepository {
    func fetchAcquisitionList() async -> Result<AcquisitionListEntity, NetworkError>
    func addAcquisition(certificationId: Int) async -> Result<BaseResponseDTO<Bool>, NetworkError>
    func fetchAcquisitionDetail(id: Int) async -> Result<AcquisitionDetailEntity, NetworkError>
    func deleteAcquisition(id: Int) async -> Result<Void, NetworkError>
}
