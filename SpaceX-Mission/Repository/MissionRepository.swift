//
//  MissionRepository.swift
//  SpaceX-Mission
//
//  Created by e.shirashiyani on 7/16/23.
//

import Foundation
import RxSwift
class SpaceXMissionRepository: MissionRepository {
    private let apiClient: SpaceXAPIClient
    
    init(apiClient: SpaceXAPIClient) {
        self.apiClient = apiClient
    }
    
    func getMissions(page: Int, completion: @escaping (Result<[Mission], Error>) -> Void) {
        apiClient.fetchMissions(page: page, completion: completion)
    }
}
//protocol MissionRepository {
//    func getMissions(pageNumber: Int) -> Observable<[Mission]>
//}

//class MissionRepositoryImpl: MissionRepository {
//    private let networkManager: NetworkManager
//
//    init(networkManager: NetworkManager) {
//        self.networkManager = networkManager
//    }
//
//    func getMissions(pageNumber: Int) -> Observable<[Mission]> {
//        return networkManager.fetchMissions(pageNumber: pageNumber)
//    }
//}
