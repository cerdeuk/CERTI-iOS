//
//  LoginFactory.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/9/26.
//

import Foundation

protocol LoginFactory {
    @MainActor func makeLoginViewModel() -> LoginViewModel
}

final class DefaultLoginFactory: LoginFactory {
    let kakoLoginUseCase: KakaoLoginUseCase

    init(kakoLoginUseCase: KakaoLoginUseCase) {
        self.kakoLoginUseCase = kakoLoginUseCase
    }

    @MainActor
    func makeLoginViewModel() -> LoginViewModel {
        LoginViewModel(kakaoLoginUseCase: kakoLoginUseCase)
    }
}
