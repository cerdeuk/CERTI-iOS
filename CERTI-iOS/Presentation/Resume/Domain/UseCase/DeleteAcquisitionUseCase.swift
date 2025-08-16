//
//  DeleteAcquisitionUseCase.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 8/16/25.
//

import Foundation

protocol DeleteAcquisitionUseCase {
    func execute(id: Int) async -> Result<Void, ResumeError>
}
