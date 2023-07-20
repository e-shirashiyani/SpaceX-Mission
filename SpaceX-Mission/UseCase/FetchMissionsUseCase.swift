//
//  FetchMissionsUseCase.swift (Domain Layer)
//  SpaceX-Mission
//
//  Created by e.shirashiyani on 7/19/23.
//
import Foundation

protocol GetMissionsUseCase {
    func execute(page: Int, completion: @escaping (Result<[Mission], Error>) -> Void)
}

class GetMissionsUseCaseImpl: GetMissionsUseCase {
    private let repository: MissionRepository
    
    init(repository: MissionRepository) {
        self.repository = repository
    }
    
    func execute(page: Int, completion: @escaping (Result<[Mission], Error>) -> Void) {
        repository.getMissions(page: page, completion: completion)
    }
}
