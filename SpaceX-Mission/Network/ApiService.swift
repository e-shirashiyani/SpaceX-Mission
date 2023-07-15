//
//  ApiService.swift
//  SpaceX-Mission
//
//  Created by e.shirashiyani on 7/15/23.
//

import Foundation
import RxSwift
import RxCocoa
enum ApiServiceError: Error {
    case networkError(Error)
    case invalidResponse
    case decodingError(Error)
}

protocol ApiServiceProtocol {
    func getMissions(pageNumber: Int) -> Observable<[Mission]>
}

class ApiService: ApiServiceProtocol {
    private let baseUrl = "https://api.spacexdata.com/v4/launches/query"
    private let session = URLSession.shared
    
    func getMissions(pageNumber: Int) -> Observable<[Mission]> {
        var request = URLRequest(url: URL(string: baseUrl)!)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json",
        ]
        let body = [
            "query": ["upcoming": false],
            "options": [
                "limit": 50,
                "page": pageNumber,
                "sort": ["flight_number": "desc"]
            ]
        ]
        let data = try! JSONSerialization.data(withJSONObject: body, options: [])
        request.httpBody = data
        
        return session.rx.data(request: request)
            .map { data in
                try JSONDecoder().decode([Mission].self, from: data)
            }
            .catch { error in
                Observable.error(ApiServiceError.networkError(error))
            }
    }
}
