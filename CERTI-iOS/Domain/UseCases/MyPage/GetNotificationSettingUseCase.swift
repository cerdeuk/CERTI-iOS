//
//  GetNotificationSettingUseCase.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/27/26.
//

import Foundation

protocol GetNotificationSettingUseCase {
    func execute() async -> Result<UserAgreementEntity, NetworkError>
}

final class DefaultGetNotificationSettingUseCase: GetNotificationSettingUseCase {
    
    private let repository: UserRepository

    init(repository: UserRepository) {
        self.repository = repository
    }

    func execute() async -> Result<UserAgreementEntity, NetworkError> {
        let result = await repository.getNotificationSetting()
        return result
    }
    
}
