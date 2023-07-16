//
//  MissionRepository.swift
//  SpaceX-Mission
//
//  Created by e.shirashiyani on 7/16/23.
//

import Foundation
import RxSwift

protocol MissionRepository {
    func getMissions(pageNumber: Int) -> Observable<[Mission]>
}

class MissionRepositoryImpl: MissionRepository {
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getMissions(pageNumber: Int) -> Observable<[Mission]> {
        return networkManager.fetchMissions(pageNumber: pageNumber)
    }
}
