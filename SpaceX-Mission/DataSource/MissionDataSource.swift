//
//  MissionDataSource.swift
//
//  Created by e.shirashiyani on 7/19/23.
//
// MissionDataSource.swift (Data Layer)
import Foundation

//protocol MissionDataSourceProtocol {
//    func fetchMissions(pageNumber: Int, completion: @escaping (Result<[Mission], Error>) -> Void)
//}
//
//class MissionDataSource: MissionDataSourceProtocol {
//    private let networkService: NetworkServiceProtocol
//    
//    init(networkService: NetworkServiceProtocol) {
//        self.networkService = networkService
//    }
//    
//    func fetchMissions(pageNumber: Int, completion: @escaping (Result<[Mission], Error>) -> Void) {
//        let url = URL(string: "https://api.spacexdata.com/v5/launches")!
//        // Modify the URL to include the required query parameters for pagination
//        // For example: https://api.spacexdata.com/v5/launches/query?page=1&limit=20
//        
//        networkService.requestData(url: url) { result in
//            switch result {
//            case .success(let data):
//                // Parse the JSON response and create an array of Mission objects
//                // Call the completion block with the array of missions
//                let missions = self.parseMissions(from: data) // Implement parseMissions() as needed
//                completion(.success(missions))
//                
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
//    private func parseMissions(from data: Data) -> [Mission] {
//        do {
//            let decoder = JSONDecoder()
//            let missionsResponse = try decoder.decode([Mission].self, from: data)
//            return missionsResponse.map { missionResponse in
//                return Mission(
//                    flightNumber: missionResponse.flightNumber,
//                    missionIconURL: missionResponse.missionIconURL,
//                    isSuccess: missionResponse.isSuccess,
//                    description: missionResponse.description,
//                    completionDate: missionResponse.completionDate,
//                    date_utc: missionResponse.date_utc
//                )
//            }
//        } catch {
//            print("Error parsing missions: \(error)")
//            return []
//        }
//    }
//}
