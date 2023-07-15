//
//  MissionEntity.swift
//  SpaceX-Mission
//
//  Created by e.shirashiyani on 7/15/23.
//

import Foundation

struct Mission: Decodable {
    let missionName: String
    let flightNumber: Int
    let launchDateUtc: Date
    let rocket: Rocket
    let links: Links
    
}
struct Rocket: Decodable {
    let name: String
    let type: String
}

struct Links: Decodable {
    let missionPatchSmall: String?
    let articleLink: String?
    let videoLink: String?
}
