//
//  JobRepository.swift
//  CERTI-iOS
//
//  Created by OneTen on 8/15/25.
//


import Foundation
import Moya

protocol JobRepository {
    func getFetchJob() async -> Result<JobListResponseDTO, NetworkError>
    func editJob(jobNameList: [String]) async -> Result<Void, NetworkError>
}
