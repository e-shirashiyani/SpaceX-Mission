//
//  MissionListViewControllerTests.swift
//  SpaceX-MissionTests
//
//  Created by e.shirashiyani on 7/20/23.
//

import XCTest
@testable import SpaceX_Mission

class MissionListViewControllerTests: XCTestCase {

    func testDidSelectMission() {
        // Given
        let mockGetMissionsUseCase = MockGetMissionsUseCase()
        let mockMissionRepository = MockMissionRepository()
        let missionListVC = MissionListViewController(getMissionsUseCase: mockGetMissionsUseCase, missionRepository: mockMissionRepository)

        // When
        missionListVC.loadViewIfNeeded() // Ensure the view is loaded
        missionListVC.didSelectMission(at: IndexPath(row: 0, section: 0))

        // Then
        // Assert that the navigation controller pushed the correct view controller
        XCTAssertTrue(missionListVC.navigationController?.topViewController is MissionDetailViewController)

        // Assert that the selected mission is passed to MissionDetailViewController
        let missionDetailVC = missionListVC.navigationController?.topViewController as? MissionDetailViewController
        XCTAssertNotNil(missionDetailVC?.mission)
        XCTAssertEqual(missionDetailVC?.mission?.flightNumber, 1)
        XCTAssertEqual(missionDetailVC?.mission?.missionName, "Mission 1")
    }

    func testMissionDetailViewControllerInitialization() {
        // Given
        let mockGetMissionDetailUseCase = MockGetMissionDetailUseCase()
        let mockBookmarkMissionUseCase = MockBookmarkMissionUseCase()
        let missionDetailVC = MissionDetailViewController(getMissionDetailUseCase: mockGetMissionDetailUseCase, bookmarkMissionUseCase: mockBookmarkMissionUseCase)

        // When
        missionDetailVC.loadViewIfNeeded() // Ensure the view is loaded

        // Then
        // Assert that mission is nil before setting
        XCTAssertNil(missionDetailVC.mission)
    }
}

// Create a mock implementation of GetMissionsUseCase for testing
class MockGetMissionsUseCase: GetMissionsUseCase {
    func execute(completion: @escaping (Result<[Mission], Error>) -> Void) {
        // Return a mock list of missions for testing
        let missions: [Mission] = [
            Mission(flightNumber: 1, missionName: "Mission 1", isSuccess: true, description: "Mission 1 Description", date: Date()),
            Mission(flightNumber: 2, missionName: "Mission 2", isSuccess: false, description: "Mission 2 Description", date: Date())
        ]
        completion(.success(missions))
    }
}

// Create a mock implementation of MissionRepository for testing
class MockMissionRepository: MissionRepository {
    func getMissions(completion: @escaping (Result<[Mission], Error>) -> Void) {
        // Return a mock list of missions for testing
        let missions: [Mission] = [
            Mission(flightNumber: 1, missionName: "Mission 1", isSuccess: true, description: "Mission 1 Description", date: Date()),
            Mission(flightNumber: 2, missionName: "Mission 2", isSuccess: false, description: "Mission 2 Description", date: Date())
        ]
        completion(.success(missions))
    }
}
