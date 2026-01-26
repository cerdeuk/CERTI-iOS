//
//  ResumePreviewUseCase.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 11/4/25.
//

import Foundation

struct PreviewFetchJobUseCase: FetchJobUseCase {
    func execute() async -> Result<JobEntity, NetworkError> {
        let dummy = JobEntity(jobs: ["IT/인터넷", "건설", "금융"])
        return .success(dummy)
    }
}

struct PreviewFetchAcquisitionListUseCase: FetchAcquisitionListUseCase {
    func execute() async -> Result<AcquisitionListEntity, NetworkError> {
        let dummy = AcquisitionListEntity(
            acquisitionList: [
                AcquisitionListEntityData(acquisitionId: 1, cardFrontImageUrl: "https://dummy.certified.com/image_certification_card_large_1.png", index: 1, name: "정보처리기사",  tags: ["컴퓨터"], description: "정처기 자격증 설명", createdAt: "2026.05.10"),
                AcquisitionListEntityData(acquisitionId: 2, cardFrontImageUrl: "https://dummy.certified.com/image_certification_card_large_1.png", index: 2, name: "GTQ 1급",  tags: ["디자인"], description: "그래픽 자격증 설명", createdAt: "2025.11.10"),
            ]
        )
        return .success(dummy)
    }
}

struct PreviewFetchAcquisitionDetailUseCase: FetchAcquisitionDetailUseCase {
    func excute(id: Int) async -> Result<AcquisitionDetailEntity, NetworkError> {
        let dummy = AcquisitionDetailEntity(
            acquisitionDetail: AcquisitionDetailEntityData(
                acquisitionId: 1,
                cardFrontImageUrl: "https://dummy.certified.com/image_certification_card_large_1.png",
                cardBackImageUrl: "https://dummy.certified.com/image_certification_card_large_1.png",
                index: 1,
                name: "정보처리기사",
                tags: ["컴퓨터"],
                description: "정처기 자격증 설명",
                createdAt: "2026.05.10"
            )
        )
        return .success(dummy)
    }
}

struct PreviewFetchActivityListUseCase: FetchActivityListUseCase {
    func execute() async -> Result<ActivityListEntity, NetworkError> {
        let dummyActivities = ActivityListEntity(list:[
            ActivityEntity(activityId: 0, startAt: "2022.03", endAt: "2022.12", name: "SOPT 35기 iOS", place: "SOPT", description: "CERTI 앱 개발 프로젝트 진행"),
            ActivityEntity(activityId: 1, startAt: "2023.03", endAt: "2023.07", name: "학교 창업동아리", place: "성균관대", description: "서비스 아이디어 기획 및 발표")
        ])
        return .success(dummyActivities)
    }
}

struct PreviewFetchCareersListUseCase: FetchCareersListUseCase {
    func execute() async -> Result<CareerListEntity, NetworkError> {
        let dummyCareers = CareerListEntity(list:[
            CareerEntity(careerId: 1, startAt: "2021.11", endAt: "2022.01", name: "패션디자이너 인턴", place: "서티그룹", description: "트렌드 리서치"),
            CareerEntity(careerId: 2, startAt: "2023.02", endAt: "2023.07", name: "iOS 개발 인턴", place: "CERTI", description: "CERTI 앱 개발 참여")
        ])
        return .success(dummyCareers)
    }
}

struct PreviewAddCareersUseCase: AddCareersUseCase {
    func execute(request: CareerEntity) async -> Result<Void, NetworkError> {
        return .success(())
    }
}

struct PreviewDeleteCareersUseCase: DeleteCareersUseCase {
    func execute(id: Int) async -> Result<Void, NetworkError> {
        return .success(())
    }
}

struct PreviewEditCareerUseCase: EditCareersUseCase {
    func execute(careerId: Int, request: CareerEntity) async -> Result<Void, NetworkError> {
        return .success(())
    }
}

struct PreviewAddActivityUseCase: AddActivityUseCase {
    func execute(request: ActivityEntity) async -> Result<Void, NetworkError> {
        return .success(())
    }
}

struct PreviewDeleteActivityUseCase: DeleteActivityUseCase {
    func execute(id: Int) async -> Result<Void, NetworkError> {
        return .success(())
    }
}

struct PreviewDeleteAcquisitionUseCase: DeleteAcquisitionUseCase {
    func execute(id: Int) async -> Result<Void, NetworkError> {
        return .success(())
    }
}
