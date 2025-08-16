//
//  AddCareerUseCase.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 8/16/25.
//

import Foundation

protocol AddCareerUseCase {
    func execute(resumeModel: ResumeModel) async -> Result<Void, ResumeError>
}

struct AddCareerUseCaseImpl: AddCareerUseCase {
    private let repository: ResumeRepository
    init(repository: ResumeRepository) { self.repository = repository }

    func execute(resumeModel: ResumeModel) async -> Result<Void, ResumeError> {
        return await repository.addCareer(resumeModel.toResumeCareer())
    }
}
