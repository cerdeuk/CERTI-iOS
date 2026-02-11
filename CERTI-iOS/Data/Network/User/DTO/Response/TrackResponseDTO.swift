//
//  TrackResponseDTO.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/29/26.
//

import Foundation

typealias TrackResponseDTO = BaseResponseDTO<TrackData>

struct TrackData: Decodable {
    let track: String
}
