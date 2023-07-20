//
//  FetchMissionsUseCase.swift (Domain Layer)
//  SpaceX-Mission
//
//  Created by e.shirashiyani on 7/19/23.
//
import Foundation

// GetMissionsUseCase.swift (Domain Layer)
protocol GetMissionsUseCase {
    func execute(page: Int,completion: @escaping (Result<[Mission], Error>) -> Void)
}

class GetMissionsInteractor: GetMissionsUseCase {
    private let missionRepository: MissionRepository

    init(missionRepository: MissionRepository) {
        self.missionRepository = missionRepository
    }

    func execute(page: Int,completion: @escaping (Result<[Mission], Error>) -> Void) {
        missionRepository.getMissions(page: page, completion: completion)
    }
}

// BookmarkMissionUseCase.swift (Domain Layer)
protocol BookmarkMissionUseCase {
    func bookmarkMission(_ mission: Mission)
    func unbookmarkMission(_ mission: Mission)
}

class BookmarkMissionInteractor: BookmarkMissionUseCase {
    func bookmarkMission(_ mission: Mission) {
        // Save the bookmark status using MissionUserDefaultsManager
        MissionUserDefaultsManager.saveBookmarkStatus(for: mission, isBookmarked: true)
    }
    
    func unbookmarkMission(_ mission: Mission) {
        // Save the unbookmark status using MissionUserDefaultsManager
        MissionUserDefaultsManager.saveBookmarkStatus(for: mission, isBookmarked: false)

    }
}
