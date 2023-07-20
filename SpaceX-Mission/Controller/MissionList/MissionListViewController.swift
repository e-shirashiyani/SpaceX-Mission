//
//  MissionListViewController.swift
//  SpaceX-Mission
//
//  Created by e.shirashiyani on 7/15/23.
//

import UIKit
import RxCocoa
import UIKit

// MissionListViewController.swift
import UIKit

class MissionListViewController: UIViewController {
    internal var missions: [Mission] = []
    internal var currentPage = 1
    private let getMissionsUseCase: GetMissionsUseCase
    private let missionRepository: MissionRepository
    private var isLoading = false
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MissionTableViewCell.self, forCellReuseIdentifier: "MissionCell")
        return tableView
    }()
    
    private lazy var loadMoreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Load More", for: .normal)
        button.addTarget(self, action: #selector(loadMoreButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
            let activityIndicator = UIActivityIndicatorView(style: .gray)
            activityIndicator.hidesWhenStopped = true
            return activityIndicator
        }()
    init(getMissionsUseCase: GetMissionsUseCase, missionRepository: MissionRepository) {
        self.getMissionsUseCase = getMissionsUseCase
        self.missionRepository = missionRepository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        fetchMissions()
    }
    
    func didSelectMission(_ mission: Mission) {
        let bookmarkMissionUseCase = BookmarkMissionInteractor()
        let detailVC = MissionDetailViewController(bookmarkMissionUseCase: bookmarkMissionUseCase)
        detailVC.mission = mission
        present(detailVC, animated: true)
//        navigationController?.pushViewController(detailVC, animated: true)

    }
    private func setupUI() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        view.addSubview(loadMoreButton)
        loadMoreButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadMoreButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadMoreButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
        view.addSubview(activityIndicator)
                activityIndicator.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                ])
    }
    
    private func fetchMissions() {
            guard !isLoading else { return } // Prevent multiple requests
            
            isLoading = true
            activityIndicator.startAnimating()
            
            getMissionsUseCase.execute(page: currentPage) { [weak self] result in
                self?.isLoading = false
                DispatchQueue.main.async {
                    
                    self?.activityIndicator.stopAnimating()
                }
                switch result {
                case .success(let missions):
                    if missions.isEmpty {
                        // Handle the scenario where there is no more data
                    } else {
                        DispatchQueue.main.async {
                            self?.missions.append(contentsOf: missions)
                            self?.tableView.reloadData()
                            self?.currentPage += 1 // Increment the page after loading data
                        }
                    }
                case .failure(let error):
                    // Handle the error
                    print("Error fetching missions: \(error)")
                }
            }
        }
    
    @objc private func loadMoreButtonTapped() {
        currentPage += 1
        tableView.reloadData()
//        fetchMissions()
    }
    
}

