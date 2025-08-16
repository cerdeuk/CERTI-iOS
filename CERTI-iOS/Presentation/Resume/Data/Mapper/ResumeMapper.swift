//
//  ResumeMapper.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 8/16/25.
//

import Foundation

// MARK: - CareerDetailResponseDTO → ResumeCareer

struct ResumeMapper {
    static func mapCareerDTOToDomain(_ dto: CareerDetailResponseDTO) -> ResumeCareer {
        return ResumeCareer(
            id: dto.careerId,
            startAt: dto.startAt,
            endAt: dto.endAt,
            name: dto.name,
            place: dto.place,
            description: dto.description
        )
    }

    // MARK: - ActivityDetailResponseDTO → ResumeActivity
    static func mapActivityDTOToDomain(_ dto: ActivityDetailResponseDTO) -> ResumeActivity {
        return ResumeActivity(
            id: dto.activityId,
            startAt: dto.startAt,
            endAt: dto.endAt,
            name: dto.name,
            place: dto.place,
            description: dto.description
        )
    }

    // MARK: - ResumeModel → ResumeCareer
    static func mapResumeModelToDomainCareer(_ model: ResumeModel) -> ResumeCareer {
        return ResumeCareer(
            id: model.careerId ?? 0,
            startAt: model.startAt,
            endAt: model.endAt,
            name: model.name,
            place: model.place,
            description: model.discription
        )
    }

    // MARK: - ResumeModel → ResumeActivity
    static func mapResumeModelToDomainActivity(_ model: ResumeModel) -> ResumeActivity {
        return ResumeActivity(
            id: model.activityId ?? 0,
            startAt: model.startAt,
            endAt: model.endAt,
            name: model.name,
            place: model.place,
            description: model.discription
        )
    }
}

// MARK: - Domain Entity → ResumeModel
extension ResumeCareer {
    func toResumeModel() -> ResumeModel {
        return ResumeModel(
            careerId: id,
            startAt: startAt,
            endAt: endAt,
            name: name,
            place: place,
            discription: description
        )
    }
}

extension ResumeActivity {
    func toResumeModel() -> ResumeModel {
        return ResumeModel(
            activityId: id,
            startAt: startAt,
            endAt: endAt,
            name: name,
            place: place,
            discription: description
        )
    }
}

extension ResumeModel {
    func toResumeCareer() -> ResumeCareer {
        return ResumeCareer(
            id: self.careerId ?? 0,
            startAt: self.startAt,
            endAt: self.endAt,
            name: self.name,
            place: self.place,
            description: self.discription
        )
    }
    
    func toResumeActivity() -> ResumeActivity {
        return ResumeActivity(
            id: activityId ?? 0,
            startAt: startAt,
            endAt: endAt,
            name: name,
            place: place,
            description: discription
        )
    }
}
