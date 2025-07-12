//
//  CERTI_iOSApp.swift
//  CERTI-iOS
//
//  Created by OneTen on 6/24/25.
//

import SwiftUI

import KakaoSDKCommon
import KakaoSDKAuth

@main
struct CERTI_iOSApp: App {
    
    init() {
        let kakaoAppKey = Bundle.main.infoDictionary?["KAKAO_APP_KEY"] as? String ?? ""
        KakaoSDK.initSDK(appKey: kakaoAppKey)
    }

    var body: some Scene {
        WindowGroup {
            RootView()
                .onOpenURL { url in
                    if AuthApi.isKakaoTalkLoginUrl(url) {
                        _ = AuthController.handleOpenUrl(url: url)
                    }
                }
        }
    }
}
