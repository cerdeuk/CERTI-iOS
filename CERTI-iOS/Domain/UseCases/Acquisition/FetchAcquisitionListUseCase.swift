//
//  FetchAcquisitionListUseCase.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 8/22/25.
//

import Foundation

protocol FetchAcquisitionListUseCase {
    func execute() async -> Result<AcquisitionListEntity, NetworkError>
}
