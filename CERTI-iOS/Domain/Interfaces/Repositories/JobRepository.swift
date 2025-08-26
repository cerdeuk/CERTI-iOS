//
//  JobRepository.swift
//  CERTI-iOS
//
//  Created by OneTen on 8/15/25.
//


import Foundation
import Moya

protocol JobRepository {
    func fetchJob() async -> Result<JobEntity, NetworkError>
    func editJob(jobNameList: JobEntity) async -> Result<Void, NetworkError>
}
