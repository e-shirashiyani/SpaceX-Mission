//
//  MissionListViewController.swift
//  SpaceX-Mission
//
//  Created by e.shirashiyani on 7/15/23.
//

import UIKit
import RxSwift
import RxCocoa

class MissionListViewController: UIViewController {
    
    private let networkService = APIService()
    private let disposeBag = DisposeBag()
    internal var missions: [Mission] = []
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        tableView.register(MissionCell.self, forCellReuseIdentifier: MissionCell.reuseIdentifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Missions"
        view.backgroundColor = .white
        configureMissionTableView()
    }
    private func configureMissionTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    private func showErrorAlert(with message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}

