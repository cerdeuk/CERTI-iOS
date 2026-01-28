//
//  CommentRepository.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 1/27/26.
//

import Foundation

import Moya

protocol CommentRepository {
    func getComment(certificationId: Int, page: Int, size: Int, sort: String) async -> Result<CommentEntity, NetworkError>
}
