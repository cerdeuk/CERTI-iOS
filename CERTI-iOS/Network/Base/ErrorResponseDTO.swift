//
//  ErrorResponseDTO.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/1/25.
//

import Foundation

struct ErrorResponseDTO: Decodable {
  let status: Int
  let message: String
}
