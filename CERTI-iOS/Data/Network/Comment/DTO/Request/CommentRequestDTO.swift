//
//  CommentRequestDTO.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 1/31/26.
//

import Foundation

struct CommentRequestDTO: Encodable {
    let content: String
    let certificationId: Int
}
