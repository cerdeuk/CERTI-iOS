//
//  ToggleNotificationSettingUseCase.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/27/26.
//

import Foundation

protocol ToggleNotificationSettingUseCase {
    func execute() async -> Result<Void, NetworkError>
}

final class DefaultToggleNotificationSettingUseCase: ToggleNotificationSettingUseCase {
    
    private let repository: UserRepository

    init(repository: UserRepository) {
        self.repository = repository
    }

    func execute() async -> Result<Void, NetworkError> {
        let result = await repository.toggleNotificationSetting()
        return result
    }
    
}
