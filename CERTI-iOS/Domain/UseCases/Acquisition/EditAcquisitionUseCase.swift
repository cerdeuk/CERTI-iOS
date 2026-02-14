//
//  EditAcquisitionUseCase.swift
//  CERTI-iOS
//
//  Created by OneTen on 2/13/26.
//

import Foundation

protocol EditAcquisitionUseCase {
    func execute(request: EditAcquisitionEntity, id: Int) async -> Result<Void, NetworkError>
}

final class DefaultEditAcquisitionUseCase: EditAcquisitionUseCase {
   private let repository: AcquisitionRepository
   
   init(repository: AcquisitionRepository) {
       self.repository = repository
   }
   
    func execute(request: EditAcquisitionEntity, id: Int) async -> Result<Void, NetworkError> {
        let result = await repository.editAcquisition(request: request, id: id)
       return result
   }
}
