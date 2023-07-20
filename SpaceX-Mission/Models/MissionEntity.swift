//
//  MissionEntity.swift
//  SpaceX-Mission
//
//  Created by e.shirashiyani on 7/15/23.
//

import Foundation

struct Mission: Decodable {
    let flight_number: Int?
    let name: String?
//    let missionIconURL: String?
    let success: Bool?
    let details: String?
    let links: Links?
    let date_utc: String?
    
}
struct Rocket: Decodable {
    let name: String?
    let type: String?
}

struct Links: Decodable {
    let patch: Patch?
    let webcast: String?
    let youtubeID: String?
    let article: String?
    let wikipedia: String?
    enum CodingKeys: String, CodingKey {
        case patch, webcast
        case youtubeID = "youtube_id"
        case article, wikipedia
    }
}

// MARK: - Patch
struct Patch: Decodable {
    let small, large: String?
}

