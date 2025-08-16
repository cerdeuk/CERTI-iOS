//
//  ResumeRepository.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 8/16/25.
//

import Foundation

protocol ResumeRepository {
    // MARK: - Career
//    func fetchCareers() async -> Result<[ResumeCareer], ResumeError>
//    func addCareer(_ item: ResumeCareer) async -> Result<Void, ResumeError>
//    func deleteCareer(id: Int) async -> Result<Void, ResumeError>

    // MARK: - Activity
//    func fetchActivities() async -> Result<[ResumeActivity], ResumeError>
//    func addActivity(_ item: ResumeActivity) async -> Result<Void, ResumeError>
//    func deleteActivity(id: Int) async -> Result<Void, ResumeError>

    // MARK: - Jobs
    func fetchJobs() async -> Result<[String], ResumeError>

    // MARK: - Acquisition
//    func fetchAcquisitionList() async -> Result<[CertificatedListModel], ResumeError>
//    func fetchAcquisitionDetail(id: Int) async -> Result<CertificatedDetailModel, ResumeError>
//    func deleteAcquisition(id: Int) async -> Result<Void, ResumeError>
}
