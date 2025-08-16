//
//  AddActivityUseCase.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 8/16/25.
//

import Foundation

protocol AddActivityUseCase {
    func execute(resumeActivity: ResumeActivity) async -> Result<Void, ResumeError>
}

struct AddActivityUseCaseImpl: AddActivityUseCase {
    private let repository: ResumeRepository
    init(repository: ResumeRepository) { self.repository = repository }

    func execute(resumeActivity: ResumeActivity) async -> Result<Void, ResumeError> {
        return await repository.addActivity(resumeActivity)
    }
}
