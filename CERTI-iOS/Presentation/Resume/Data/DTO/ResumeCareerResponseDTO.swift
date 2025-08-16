//
//  ResumeCareerResponseDTO.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 8/16/25.
//

import Foundation

extension CareerDetailResponseDTO {
    func toDomain() -> ResumeCareer {
        return ResumeCareer(
            id: self.id,
            startAt: self.startAt,
            endAt: self.endAt,
            name: self.name,
            place: self.place,
            description: self.description
        )
    }
}
