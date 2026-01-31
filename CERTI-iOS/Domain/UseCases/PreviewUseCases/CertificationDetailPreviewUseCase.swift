//
//  CertificationDetailPreviewUseCase.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 11/16/25.
//

struct PreviewFetchCertificationDetailUseCase: FetchCertificationDetailUseCase {
    func execute(id: Int) async -> Result<CertificationDetailEntity, NetworkError> {
        let dummy = CertificationDetailEntity(
            certificationId: id,
            certificationName: "GTQ 1급 (그래픽기술자격)",
            tags: ["디자인", "그래픽"],
            averagePeriod: "2개월",
            charge: "35,000원",
            agencyName: "한국생산성본부",
            testType: "필기/실기",
            description: "그래픽 편집 능력을 평가하는 자격으로, 포토샵 및 일러스트 사용 능력을 측정합니다.",
            testDateInformation: "매월 정기 시행",
            applicationMethod: "온라인 접수",
            applicationUrl: "https://www.kpc.or.kr/gtq",
            expirationPeriod: "영구"
        )
        return .success(dummy)
    }
}

struct PreviewAddPreCertificationUseCase: AddPreCertificationUseCase {
    func execute(request: AddPreCertificationEntity) async -> Result<AppendPreCertificationStatus, NetworkError> {
        // Always succeed for preview
        return .success(.success)
    }
}

struct PreviewAddAcquisitionUseCase: AddAcquisitionUseCase {
    func execute(request: AddAcquisitionEntity) async -> Result<Bool, NetworkError> {
        // Always succeed for preview
        return .success(true)
    }
}
