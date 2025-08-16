//
//  DeleteActivityUseCase.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 8/16/25.
//
//
//import Foundation
//
//protocol DeleteActivityUseCase {
//    func execute(id: Int) async -> Result<Void, ResumeError>
//}
//
//struct DeleteActivityUseCaseImpl: DeleteActivityUseCase {
//    private let repository: ResumeRepository
//    init(repository: ResumeRepository) { self.repository = repository }
//
//    func execute(id: Int) async -> Result<Void, ResumeError> {
//        return await repository.deleteActivity(id: id)
//    }
//}
