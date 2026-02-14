//
//  ToggleMarketingSettingUseCase.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/27/26.
//

import Foundation

protocol ToggleMarketingSettingUseCase {
    func execute(agree: Bool) async -> Result<Void, NetworkError>
}

final class DefaultToggleMarketingSettingUseCase: ToggleMarketingSettingUseCase {
    
    private let repository: UserRepository

    init(repository: UserRepository) {
        self.repository = repository
    }

    func execute(agree: Bool) async -> Result<Void, NetworkError> {
        let result = await repository.toggleMarketingSetting(agree: agree)
        return result
    }
    
}
