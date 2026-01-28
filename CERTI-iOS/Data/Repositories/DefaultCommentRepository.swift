//
//  DefaultCommentRepository.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 1/27/26.
//

import Foundation

import Moya

final class DefaultCommentRepository: CommentRepository {
    private let service: CommentServiceProtocol
    
    public init(service: CommentServiceProtocol) {
        self.service = service
    }
    
    func getComment(certificationId: Int, page: Int, size: Int, sort: String) async -> Result<CommentEntity, NetworkError> {
        let result = await service.getComment(certificationId: certificationId, page: page, size: size, sort: sort)
        
        switch result {
        case .success(let dto):
            guard let entity = dto.data?.toCommentEntity() else {
                return .failure(.decodingError)
            }
            return .success(entity)
        case .failure(let error):
            return .failure(error)
        }
    }
}
