//
//  ApiService.swift
//  SpaceX-Mission
//
//  Created by e.shirashiyani on 7/15/23.
//

import UIKit
import RxSwift
import RxCocoa

protocol NetworkService {
    func fetchMissions(pageNumber: Int) -> Observable<[Mission]>
    
}
