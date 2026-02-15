//
//  PresignedURLResponseDTO.swift
//  CERTI-iOS
//
//  Created by nayeon on 2/14/26.
//

typealias PresignedURLResponseDTO = BaseResponseDTO<PresignedURLResponseData>

struct PresignedURLResponseData: Decodable {
    let preSignedURL: String
    let publicURL: String
    
    func toPresignedURLEntity() -> PresignedURLEntity {
        return PresignedURLEntity(
            preSignedURL: preSignedURL,
            publicURL: publicURL
        )
    }
}
