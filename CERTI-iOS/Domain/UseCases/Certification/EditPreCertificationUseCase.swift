//
//  EditPreCertificationUseCase.swift
//  CERTI-iOS
//
//  Created by OneTen on 2/13/26.
//

import Foundation

protocol EditPreCertificationUseCase {
    func execute(request: EditPreCertificationEntity, id: Int) async -> Result<Void, NetworkError>
}

final class DefaultEditPreCertificationUseCase: EditPreCertificationUseCase {
   private let repository: HomeRepository
   
   init(repository: HomeRepository) {
       self.repository = repository
   }
   
    func execute(request: EditPreCertificationEntity, id: Int) async -> Result<Void, NetworkError> {
        let result = await repository.editPreCertification(request: request, id: id)
       return result
   }
}
