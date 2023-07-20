//
//  MissionDetailViewController.swift
//  SpaceX-Mission
//
//  Created by e.shirashiyani on 7/20/23.
//

import Foundation
import UIKit

import UIKit

class MissionDetailViewController: UIViewController {
    var mission: Mission?
    
    private let missionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let missionNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let completionDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let wikipediaButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Open Wikipedia", for: .normal)
        button.addTarget(self, action: #selector(openWikipedia), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.addTarget(MissionDetailViewController.self, action: #selector(bookmarkButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        displayMissionDetails()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        // Add subviews to the view
        view.addSubview(missionImageView)
        view.addSubview(descriptionLabel)
        view.addSubview(missionNameLabel)
        view.addSubview(completionDateLabel)
        view.addSubview(wikipediaButton)
        view.addSubview(bookmarkButton)
        
        // Set up constraints for subviews
        NSLayoutConstraint.activate([
            missionImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            missionImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            missionImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            missionImageView.heightAnchor.constraint(equalToConstant: 200),
            
            descriptionLabel.topAnchor.constraint(equalTo: missionImageView.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            descriptionLabel.heightAnchor.constraint(equalToConstant: 50),

            
            missionNameLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            missionNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            missionNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            completionDateLabel.topAnchor.constraint(equalTo: missionNameLabel.bottomAnchor, constant: 8),
            completionDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            completionDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            wikipediaButton.topAnchor.constraint(equalTo: completionDateLabel.bottomAnchor, constant: 16),
            wikipediaButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            bookmarkButton.topAnchor.constraint(equalTo: wikipediaButton.bottomAnchor, constant: 16),
            bookmarkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func displayMissionDetails() {
        guard let mission = mission else {
            return
        }
        
        // Update UI elements with mission details
//        missionImageView.image = UIImage(named: mission.imageName)
        loadImage(url: URL(string: mission.links?.patch?.large ?? "") ?? URL(fileURLWithPath: ""))
        descriptionLabel.text = mission.details
        missionNameLabel.text = mission.name
        completionDateLabel.text = "Completion Date: \(loadLocalTime(utc: mission.date_utc ?? ""))"
        
        if mission.links?.wikipedia?.isEmpty ?? true {
            wikipediaButton.isHidden = true
        }
    }
    
    @objc private func openWikipedia() {
        guard let mission = mission, !(mission.links?.wikipedia?.isEmpty ?? true), let url = URL(string: mission.links?.wikipedia ?? "") else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @objc private func bookmarkButtonTapped() {
        // Implement bookmark feature here (e.g., save mission to bookmarks or remove from bookmarks)
        // You can use UserDefaults, Core Data, or any other data storage mechanism to manage bookmarks
        // Update bookmarkButton appearance based on bookmark status
    }
    private func loadLocalTime(utc: String) -> String {
        var result : String?
        if let localTime = DateTimeConverter.convertUTCToLocal(dateString: utc) {
            result = "Local Time: \(localTime)"
        } else {
            result = "Date: N/A"
        }
        return result ?? ""
    }
    
    private func loadImage(url: URL) {
        ImageLoader.shared.loadImage(from: url) { image in
            DispatchQueue.main.async {
                self.missionImageView.image = image
            }
        }
    }
}
