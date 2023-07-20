//
//  MissionUserDefaultsManager.swift
//  SpaceX-Mission
//
//  Created by e.shirashiyani on 7/20/23.
//

import Foundation
import Foundation
class MissionUserDefaultsManager {
    private static let bookmarkKeyPrefix = "bookmark_"
    
    static func saveBookmarkStatus(for mission: Mission, isBookmarked: Bool) {
        let key = bookmarkKey(for: mission)
        UserDefaults.standard.set(isBookmarked, forKey: key)
    }
    
    static func isMissionBookmarked(_ mission: Mission) -> Bool {
        let key = bookmarkKey(for: mission)
        return UserDefaults.standard.bool(forKey: key)
    }
    
    private static func bookmarkKey(for mission: Mission) -> String {
        return bookmarkKeyPrefix + "\(mission.flight_number ?? 0)"
    }
}
