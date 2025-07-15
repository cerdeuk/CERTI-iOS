//
//  EmptyResponseDTO.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/15/25.
//

import Foundation

typealias EmptyResponseDTO = BaseResponseDTO<EmptyData>

struct EmptyData: Decodable {}
