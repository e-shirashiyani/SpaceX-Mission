//
//  MissionEntity.swift
//  SpaceX-Mission
//
//  Created by e.shirashiyani on 7/15/23.
//

import Foundation

struct Mission: Decodable {
    let name: String?
    let flight_number: Int?
    let date_utc: String?
//    let rocket: Rocket?
    let links: Links?
    
}
struct Rocket: Decodable {
    let name: String?
    let type: String?
}

struct Links: Decodable {
    let missionPatchSmall: String?
    let articleLink: String?
    let videoLink: String?
}
extension Mission {
    
    var formattedLaunchDate: String? {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            
            guard let launchDateStr = date_utc else {
                return nil
            }
            
            guard let launchDate = dateFormatter.date(from: launchDateStr) else {
                return nil
            }
            
            dateFormatter.dateFormat = "MMMM d, yyyy"
            let formattedDate = dateFormatter.string(from: launchDate)
            return formattedDate
        }
        
    
}
