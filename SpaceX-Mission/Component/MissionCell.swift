//
//  MissionCell.swift
//  SpaceX-Mission
//
//  Created by e.shirashiyani on 7/15/23.
//

import UIKit

class MissionCell: UITableViewCell {
    static let reuseIdentifier = "MissionCell"
    private let missionNameLabel = UILabel()
    private let missionDateLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureMissionNameLabel()
        configureMissionDateLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with mission: Mission) {
        missionNameLabel.text = mission.name
        missionDateLabel.text = mission.formattedLaunchDate
    }
    private func configureMissionNameLabel() {
        contentView.addSubview(missionNameLabel)
        missionNameLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        missionNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            missionNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            missionNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            missionNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
        
    }
    private func configureMissionDateLabel() {
        contentView.addSubview(missionDateLabel)
        missionDateLabel.font = UIFont.systemFont(ofSize: 14)
        missionDateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            missionDateLabel.topAnchor.constraint(equalTo: missionNameLabel.bottomAnchor, constant: 4),
            missionDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            missionDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            missionDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
        
    }
