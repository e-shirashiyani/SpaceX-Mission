//
//  Mission.swift
//  SpaceX-Mission
//
//  Created by e.shirashiyani on 7/15/23.
//

import Foundation
struct Mission: Codable {
    let missionName: String
    let flightNumber: Int
    let launchDateUtc: Date
    let rocket: Rocket
    let links: Links
    
    private enum CodingKeys: String, CodingKey {
        case missionName = "name"
        case flightNumber = "flight_number"
        case launchDateUtc = "date_utc"
        case rocket
        case links
    }
    
}

struct Rocket: Codable {
    let name: String
    let type: String
}

struct Links: Codable {
    let missionPatchSmall: String?
    let articleLink: String?
    let videoLink: String?
}
