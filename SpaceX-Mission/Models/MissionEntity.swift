//
//  MissionEntity.swift
//  SpaceX-Mission
//
//  Created by e.shirashiyani on 7/15/23.
//

import Foundation
import CoreData

@objc(MissionEntity)
class MissionEntity: NSManagedObject {
    @NSManaged var missionName: String?
    @NSManaged var flightNumber: Int32
    @NSManaged var launchDateUtc: Date?
    @NSManaged var rocketName: String?
    @NSManaged var rocketType: String?
    @NSManaged var missionPatchSmall: String?
    @NSManaged var articleLink: String?
    @NSManaged var videoLink: String?
}

struct Mission: Decodable {
    let missionName: String
    let flightNumber: Int
    let launchDateUtc: Date
    let rocket: Rocket
    let links: Links
    
    init(from entity: MissionEntity) {
        missionName = entity.missionName ?? ""
        flightNumber = Int(entity.flightNumber)
        launchDateUtc = entity.launchDateUtc ?? Date()
        rocket = Rocket(name: entity.rocketName ?? "", type: entity.rocketType ?? "")
        links = Links(missionPatchSmall: entity.missionPatchSmall, articleLink: entity.articleLink, videoLink: entity.videoLink)
    }
    
    func save(in context: NSManagedObjectContext) {
        let entity = MissionEntity(context: context)
        entity.missionName = missionName
        entity.flightNumber = Int32(flightNumber)
        entity.launchDateUtc = launchDateUtc
        entity.rocketName = rocket.name
        entity.rocketType = rocket.type
        entity.missionPatchSmall = links.missionPatchSmall
        entity.articleLink = links.articleLink
        entity.videoLink = links.videoLink
        
        do {
            try context.save()
        } catch {
            print("Error saving mission: \(error)")
        }
    }
    
        static func fetchAll(in context: NSManagedObjectContext) -> [Mission] {
            let request = NSFetchRequest<MissionEntity>(entityName: "MissionEntity")
            let entities = (try? context.fetch(request)) ?? []
            return entities.map { Mission(from: $0) }
    }
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
