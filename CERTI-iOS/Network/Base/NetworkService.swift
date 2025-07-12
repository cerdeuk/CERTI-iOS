//
//  NetworkService.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/1/25.
//

import Foundation

final class NetworkService {
    
    static let shared = NetworkService()
    
    private init() { }
    
    /// 이런식으로 서비스들 모아서 이 곳에서 선언 후 네트워크 서비스라는 객체를 하나만 생성해서 싱글톤 패턴으로 사용
    /// 일단 앱잼에서는 이렇게 사용하지만, 추후 아키텍처 고민하면서 DI 컨테이너 같은 거 활용하는 방향으로 리팩토링 하면 좋을 것 같아요
    /// let authService: AuthServiceProtocol = AuthService()

    let tokenRefreshService: TokenRefreshServiceProtocol = TokenRefreshService()
    let authService: AuthServiceProtocol = AuthService()

}
