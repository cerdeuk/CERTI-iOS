//
//  ResumeModel.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/12/25.
//

import SwiftUI

struct ResumeModel: Identifiable {
    var id: UUID = UUID()
    
    var activityId: Int?
    var careerId: Int?
    var startAt: String
    var endAt: String
    var name: String
    var place: String
    var description: String
}

extension ResumeModel {
    static func myCareerDummy() -> [ResumeModel] {
        return [ ResumeModel(startAt: "2021.11", endAt: "2022.01", name: "패션디자이너 인턴ㅇ", place: "서티그룹ㅇㅇㅇㅇㅇㅇ", description: "트렌드 리서치 및 소재 조사ㅇ"),
                 ResumeModel(startAt: "2021.11", endAt: "2022.01", name: "패션디자이너 인턴ㅇ", place: "서티그룹ㅇㅇㅇㅇㅇㅇ", description: "트렌드 리서치 및 소재 조사ㅇ"),
                 ResumeModel(startAt: "2021.11", endAt: "2022.01", name: "패션디자이너 인턴ㅇ", place: "서티그룹ㅇㅇㅇㅇㅇㅇ", description: "트렌드 리서치 및 소재 조사ㅇ"),
                 ResumeModel(startAt: "2021.11", endAt: "2022.01", name: "패션디자이너 인턴ㅇ", place: "서티그룹ㅇㅇㅇㅇㅇㅇ", description: "트렌드 리서치 및 소재 조사ㅇ"),
        ]
    }
    
    static func myExtracurricularActivityDummy() -> [ResumeModel] {
        return [ ResumeModel(startAt: "2021.11", endAt: "2022.01", name: "동아리 36기 기획", place: "SOPTㅇㅇㅇㅇㅇㅇ", description: "서비스 기획 및 아이디어 도출"),
                 ResumeModel(startAt: "2021.11", endAt: "2022.01", name: "동아리 36기 기획", place: "SOPTㅇㅇㅇㅇㅇㅇ", description: "서비스 기획 및 아이디어 도출"),
                 ResumeModel(startAt: "2021.11", endAt: "2022.01", name: "동아리 36기 기획", place: "SOPTㅇㅇㅇㅇㅇㅇ", description: "서비스 기획 및 아이디어 도출"),
                 ResumeModel(startAt: "2021.11", endAt: "2022.01", name: "동아리 36기 기획", place: "SOPTㅇㅇㅇㅇㅇㅇ", description: "서비스 기획 및 아이디어 도출"),
        ]
    }}

extension ResumeModel {
    
    
    // MARK: - Func
    
    func toCareersEntity() -> CareersEntity {
        return CareersEntity(
            data: ResumeEntityData(
                startAt: startAt,
                endAt: endAt,
                name: name,
                place: place,
                description: description
            )
        )
    }
    
    func toActivityEntity() -> ActivityEntity {
        return ActivityEntity(
            data: ResumeEntityData(
            startAt: startAt,
            endAt: endAt,
            name: name,
            place: place,
            description: description
            )
        )
    }
}
