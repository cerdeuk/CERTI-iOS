//
//  ResumeError.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 8/16/25.
//

import Foundation

// MARK: - ResumeError (Domain Layer Error)

enum ResumeError: Error {
    case networkError(message: String)
    case decodingError
    case unknown
}
