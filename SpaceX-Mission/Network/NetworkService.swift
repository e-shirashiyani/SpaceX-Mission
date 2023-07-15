//
//  ApiService.swift
//  SpaceX-Mission
//
//  Created by e.shirashiyani on 7/15/23.
//

import UIKit
import RxSwift
import RxCocoa

//network layer
class NetworkService {
    
    private let session = URLSession.shared
    private let baseURL = URL(string: "https://api.spacexdata.com/v3")!
    
    enum NetworkError: Error {
        case invalidURL
        case invalidResponse
        case decodingError(Error)
        case serverError(Int)
        case clientError(Int)
        case unknownError
    }
    
    func fetchMissions(upcoming: Bool) -> Single<Result<[Mission], NetworkError>> {
        let url = baseURL.appendingPathComponent("launches")
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.queryItems = [
            URLQueryItem(name: "launch_success", value: "true"),
            URLQueryItem(name: "order", value: "desc"),
            URLQueryItem(name: "sort", value: "launch_date_utc"),
            URLQueryItem(name: "limit", value: "20")
        ]
        if upcoming {
            components.queryItems?.append(URLQueryItem(name: "upcoming", value: "true"))
        }
        guard let requestURL = components.url else {
            return .just(.failure(.invalidURL))
        }
        let request = URLRequest(url: requestURL)
        
        return session.rx
            .data(request: request)
            .map { data in
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                do {
                    let missions = try decoder.decode([Mission].self, from: data)
                    return .success(missions)
                } catch {
                    return .failure(.decodingError(error))
                }
            }
            .catch { error in
                if let urlError = error as? URLError {
                    switch urlError.code {
                    case .notConnectedToInternet:
                        return .just(.failure(.clientError(404)))
                    case .timedOut:
                        return .just(.failure(.clientError(408)))
                    default:
                        return .just(.failure(.unknownError))
                    }
                }
                let nsError = error as NSError
                if nsError.domain == NSURLErrorDomain {
                    switch nsError.code {
                    case NSURLErrorCancelled:
                        return .empty()
                    default:
                        return .just(.failure(.unknownError))
                    }
                }
                if let httpResponse = nsError.userInfo[NSUnderlyingErrorKey] as? HTTPURLResponse {
                    let statusCode = httpResponse.statusCode
                    if statusCode >= 400 && statusCode < 500 {
                        return .just(.failure(.clientError(statusCode)))
                    } else if statusCode >= 500 {
                        return .just(.failure(.serverError(statusCode)))
                    }
                }
                return .just(.failure(.unknownError))
            }
            .asSingle()
    }
    
    func fetchMissionImage(_ mission: Mission) -> Single<Result<UIImage?, NetworkError>> {
        guard let imageURLString = mission.links.missionPatchSmall, let imageURL = URL(string: imageURLString) else {
            return .just(.failure(.invalidURL))
        }
        
        let request = URLRequest(url: imageURL)
        
        return session.rx
            .data(request: request)
            .map { data in
                let image = UIImage(data: data)
                return .success(image)
            }
            .catch { error in
                if let urlError = error as? URLError {
                    switch urlError.code {
                    case .notConnectedToInternet:
                        return .just(.failure(.clientError(404)))
                    case .timedOut:
                        return .just(.failure(.clientError(408)))
                    default:
                        return .just(.failure(.unknownError))
                    }
                }
                let nsError = error as NSError
                if nsError.domain == NSURLErrorDomain {
                    switch nsError.code {
                    case NSURLErrorCancelled:
                        return .empty()
                    default:
                        return .just(.failure(.unknownError))
                    }
                }
                if let httpResponse = nsError.userInfo[NSUnderlyingErrorKey] as? HTTPURLResponse {
                    let statusCode = httpResponse.statusCode
                    if statusCode >= 400 && statusCode < 500 {
                        return .just(.failure(.clientError(statusCode)))
                    } else if statusCode >= 500 {
                        return .just(.failure(.serverError(statusCode)))
                    }
                }
                return .just(.failure(.unknownError))
            }
            .asSingle()
    }
    
}
