//
//  ApiService.swift
//  SpaceX-Mission
//
//  Created by e.shirashiyani on 7/16/23.
//

import RxCocoa
import RxSwift
import Foundation

class NetworkManager {
    
        private let baseURL = "https://api.spacexdata.com/v5/"
        private let session: URLSession
        
        init(session: URLSession = URLSession.shared) {
            self.session = session
        }
        
        func fetchMissions(pageNumber: Int) -> Observable<[Mission]> {
            guard let url = URL(string: "\(baseURL)/launches") else {
                return Observable.error(NetworkError.invalidURL)
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let parameters: [String: Any] = [
                "query": [
                    "upcoming": false
                ],
                "options": [
                    "limit": 50,
                    "page": pageNumber,
                    "sort": [
                        "flight_number": "desc"
                    ]
                ] as [String : Any]
            ]
            
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                return Observable.error(NetworkError.requestFailed)
            }
            
            return session.rx.data(request: request)
                .map { data in
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    return try decoder.decode([Mission].self, from: data)
                }
                .catch { error in
                    return Observable.error(NetworkError.decodingFailed)
                }
        }
        
        func fetchMissionDetails(missionID: String) -> Observable<Mission> {
            guard let url = URL(string: "\(baseURL)/missions/\(missionID)") else {
                return Observable.error(NetworkError.invalidURL)
            }
            
            let request = URLRequest(url: url)
            
            return session.rx.data(request: request)
                .map { data in
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    return try decoder.decode(Mission.self, from: data)
                }
                .catch { error in
                    return Observable.error(NetworkError.decodingFailed)
                }
        }
    }
enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case invalidResponse
    case decodingFailed
}
