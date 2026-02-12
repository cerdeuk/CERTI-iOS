//
//  TogglePrivacySettingUseCase.swift
//  CERTI-iOS
//
//  Created by OneTen on 2/13/26.
//

import Foundation

protocol TogglePrivacySettingUseCase {
    func execute(agree: Bool) async -> Result<Void, NetworkError>
}

final class DefaultTogglePrivacySettingUseCase: TogglePrivacySettingUseCase {
    
    private let repository: UserRepository

    init(repository: UserRepository) {
        self.repository = repository
    }

    func execute(agree: Bool) async -> Result<Void, NetworkError> {
        let result = await repository.togglePrivacySetting(agree: agree)
        return result
    }
    
}
