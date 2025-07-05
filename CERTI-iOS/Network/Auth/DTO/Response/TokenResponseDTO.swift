//
//  TokenResponseDTO.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/5/25.
//

import Foundation

typealias TokenResponseDTO = BaseResponseDTO<AccessTokenData>

struct AccessTokenData: Decodable {
    let accessToken: String
}
