//
//  MissionRepository.swift
//  SpaceX-Mission
//
//  Created by e.shirashiyani on 7/16/23.
//

import Foundation
import RxSwift
// MissionRepository.swift (Data Layer)
protocol MissionRepository {
    func getMissions(page: Int,completion: @escaping (Result<[Mission], Error>) -> Void)
}

// SpaceXMissionRepository.swift (Data Layer)
class SpaceXMissionRepository: MissionRepository {
    
    private let apiClient: SpaceXAPIClient

    init(apiClient: SpaceXAPIClient) {
        self.apiClient = apiClient
    }

    func getMissions(page: Int,completion: @escaping (Result<[Mission], Error>) -> Void) {
        apiClient.fetchMissions(page: page) { result in
            // Parse the API response and return the result
            switch result {
            case .success(let missions):
                completion(.success(missions))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
