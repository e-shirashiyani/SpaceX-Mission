//
//  MissionListViewModel.swift
//  SpaceX-Mission
//
//  Created by e.shirashiyani on 7/15/23.
//

import Foundation
import RxSwift
import RxCocoa

class MissionListViewModel {
    
    private let networkService = NetworkService()
    private let disposeBag = DisposeBag()
    
    // Inputs
    let didSelectMission = PublishRelay<Mission>()
    
    // Outputs
    let isLoading = BehaviorRelay(value: false)
    let error = PublishRelay<Error>()
    let missions = BehaviorRelay<[Mission]>(value: [])
    
    init() {
        didSelectMission
            .subscribe(onNext: { [weak self] mission in
//                let detailsViewModel = MissionDetailsViewModel(mission: mission)
//                let detailsVC = MissionDetailsViewController(viewModel: detailsViewModel)
                // Present details view controller
            })
            .disposed(by: disposeBag)
    }
    
    func fetchMissions() {
        isLoading.accept(true)
        networkService.fetchMissions(upcoming: false)
            .subscribe(onSuccess: { result in
                    switch result {
                    case .success(let missions):
                        self.isLoading.accept(false)
                        self.missions.accept(missions)
                    case .failure(let error):
                        self.isLoading.accept(false)
                       self.error.accept(error)
                    }
            }, onFailure: { error in
                self.isLoading.accept(false)
                self.error.accept(error)
                })
                .disposed(by: disposeBag)
    }
    
}
