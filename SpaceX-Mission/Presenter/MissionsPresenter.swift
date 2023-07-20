//
//  MissionsPresenter.swift (Presentation Layer)
//  SpaceX-Mission
//
//  Created by e.shirashiyani on 7/19/23.
//
import Foundation

protocol MissionsViewProtocol: AnyObject {
    func showMissions(_ missions: [Mission])
    func showError(message: String)
}
import Foundation

//protocol MissionsPresenterProtocol {
//    func loadMissions(pageNumber: Int)
//}
//
//class MissionsPresenter: MissionsPresenterProtocol {
//    private let fetchMissionsUseCase: FetchMissionsUseCaseProtocol
////    private weak var view: MissionsViewProtocol?
//    private var currentPage = 1
//    
//    init(fetchMissionsUseCase: FetchMissionsUseCaseProtocol) {
//        self.fetchMissionsUseCase = fetchMissionsUseCase
////        self.view = view
//    }
//    
//    func loadMissions(pageNumber: Int) {
//        currentPage = pageNumber
//        fetchMissionsUseCase.execute(pageNumber: pageNumber) { [weak self] result in
//            switch result {
//            case .success(let missions):
//                break
////                self?.view?.showMissions(missions)
//                
//            case .failure(let error):
//                break
////                self?.view?.showError(message: error.localizedDescription)
//            }
//        }
//    }
//}
