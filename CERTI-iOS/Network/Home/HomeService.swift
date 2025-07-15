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
}

