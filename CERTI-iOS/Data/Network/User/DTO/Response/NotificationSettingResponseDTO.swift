//
//  NotificationSettingResponseDTO.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/27/26.
//

import Foundation

typealias NotificationSettingResponseDTO = BaseResponseDTO<NotificationSettingData>

struct NotificationSettingData: Codable {
    let isAdAgreed: Bool
    let isPvAgreed: Bool
}

