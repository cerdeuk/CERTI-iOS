//
//  ActivityRepository.swift
//  CERTI-iOS
//
//  Created by OneTen on 8/15/25.
//


import Foundation
import Moya

protocol ActivityRepository {
    func fetchActivityList() async -> Result<ActivityDetailEntity, NetworkError>
    func deleteActivity(id: Int) async -> Result<Void, NetworkError>
    func addActivity(request: ActivityEntity) async -> Result<Void, NetworkError>
}
