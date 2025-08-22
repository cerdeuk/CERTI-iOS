//
//  AddAcquisitionUseCase.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 8/22/25.
//

import Foundation

 protocol AddAcquisitionUseCase {
    func execute(certificationId: Int) async -> Result<Bool, NetworkError>
}
