//
//  MissionDetailViewControllerTests.swift
//  SpaceX-MissionTests
//
//  Created by e.shirashiyani on 7/20/23.
//

import XCTest
@testable import SpaceX_Mission

class MissionDetailViewControllerTests: XCTestCase {

    func testBookmarkButtonTapped() {
        // Given
        let mockGetMissionDetailUseCase = MockGetMissionDetailUseCase()
        let mockBookmarkMissionUseCase = MockBookmarkMissionUseCase()
        let missionDetailVC = MissionDetailViewController(getMissionDetailUseCase: mockGetMissionDetailUseCase, bookmarkMissionUseCase: mockBookmarkMissionUseCase)

        // When
        missionDetailVC.loadViewIfNeeded() // Ensure the view is loaded
        missionDetailVC.mission = Mission(flightNumber: 1, missionName: "Mission 1", isSuccess: true, description: "Mission 1 Description", date: Date())
        missionDetailVC.bookmarkButtonTapped()

        // Then
        // Assert that bookmarkMissionUseCase is called with the correct mission when bookmarkButton is tapped
        XCTAssertTrue(mockBookmarkMissionUseCase.bookmarkMissionCalled)
        XCTAssertEqual(mockBookmarkMissionUseCase.bookmarkedMission?.flightNumber, 1)
        XCTAssertEqual(mockBookmarkMissionUseCase.bookmarkedMission?.missionName, "Mission 1")
    }

    func testUpdateBookmarkButtonAppearance() {
        // Given
        let mockGetMissionDetailUseCase = MockGetMissionDetailUseCase()
        let mockBookmarkMissionUseCase = MockBookmarkMissionUseCase()
        let missionDetailVC = MissionDetailViewController(getMissionDetailUseCase: mockGetMissionDetailUseCase, bookmarkMissionUseCase: mockBookmarkMissionUseCase)

        // When
        missionDetailVC.loadViewIfNeeded() // Ensure the view is loaded
        missionDetailVC.mission = Mission(flightNumber: 1, missionName: "Mission 1", isSuccess: true, description: "Mission 1 Description", date: Date())
        missionDetailVC.updateBookmarkButtonAppearance()

        // Then
        // Assert that bookmark button image is updated based on the bookmark status
        XCTAssertEqual(missionDetailVC.bookmarkButton.image(for: .normal), UIImage(systemName: "bookmark.fill"))
    }
}

// Create a mock implementation of GetMissionDetailUseCase for testing
class MockGetMissionDetailUseCase: GetMissionDetailUseCase {
    func execute(missionId: String, completion: @escaping (Result<MissionDetail, Error>) -> Void) {
        // Return a mock mission detail for testing
        let missionDetail = MissionDetail(name: "Mission 1", imageUrl: "https://images2.imgbox.com/94/f2/NN6Ph45r_o.png", description: "Mission 1 Description", wikipediaLink: "https://en.wikipedia.org/wiki/Mission_1")
        completion(.success(missionDetail))
    }
}

// Create a mock implementation of BookmarkMissionUseCase for testing
class MockBookmarkMissionUseCase: BookmarkMissionUseCase {
    var bookmarkMissionCalled = false
    var unbookmarkMissionCalled = false
    var bookmarkedMission: Mission?

    func bookmarkMission(_ mission: Mission) {
        bookmarkMissionCalled = true
        bookmarkedMission = mission
    }

    func unbookmarkMission(_ mission: Mission) {
        unbookmarkMissionCalled = true
        bookmarkedMission = mission
    }
}
