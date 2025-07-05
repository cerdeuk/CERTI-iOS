//
//  BaseResponseDTO.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/1/25.
//

import Foundation

struct BaseResponseDTO<T: Decodable>: Decodable {
    let status: Int
    let message: String
    let data: T?
}
