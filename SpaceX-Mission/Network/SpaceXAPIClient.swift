//
//  ApiService.swift
//  SpaceX-Mission
//
//  Created by e.shirashiyani on 7/15/23.
//

import UIKit
import RxSwift
import RxCocoa

// SpaceXAPIClient.swift (API Client)
    class SpaceXAPIClient {
        private let baseURL = "https://api.spacexdata.com/v5/launches"
        
        func fetchMissions(page: Int, completion: @escaping (Result<[Mission], Error>) -> Void) {
            guard var urlComponents = URLComponents(string: baseURL) else {
                let error = NSError(domain: "URLCreationError", code: 0, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            let queryItems = [
                URLQueryItem(name: "query", value: "{\"upcoming\":false}"),
                URLQueryItem(name: "options", value: "{\"limit\":50,\"page\":\(page),\"sort\":{\"flight_number\":\"desc\"}}")
            ]
            
            urlComponents.queryItems = queryItems
            
            guard let url = urlComponents.url else {
                let error = NSError(domain: "URLCreationError", code: 0, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    let statusCodeError = NSError(domain: "ResponseError", code: (response as? HTTPURLResponse)?.statusCode ?? 0, userInfo: nil)
                    completion(.failure(statusCodeError))
                    return
                }
                
                guard let data = data else {
                    let error = NSError(domain: "ResponseError", code: 0, userInfo: nil)
                    completion(.failure(error))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let missions = try decoder.decode([Mission].self, from: data)
                    completion(.success(missions))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        }
    }
