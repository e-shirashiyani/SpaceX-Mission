//
//  MissionCell.swift
//  SpaceX-Mission
//
//  Created by e.shirashiyani on 7/15/23.
//

import UIKit

class MissionTableViewCell: UITableViewCell {

    private let missionIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        // Add any additional image view configurations here
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(missionIconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(statusLabel)
        contentView.addSubview(dateLabel)
        
        missionIconImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            missionIconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            missionIconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            missionIconImageView.widthAnchor.constraint(equalToConstant: 50),
            missionIconImageView.heightAnchor.constraint(equalToConstant: 50),
            
            titleLabel.leadingAnchor.constraint(equalTo: missionIconImageView.trailingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            statusLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            statusLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            statusLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            dateLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 4),
            dateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
        ])
    }
    
    func configure(with mission: Mission) {
        titleLabel.text = "Flight Number: \(mission.flight_number ?? 0)"
        statusLabel.text = mission.success ?? false ? "Success" : "Failure"
        dateLabel.text = loadLocalTime(utc: mission.date_utc ?? "")
        loadImage(url: URL(string: mission.links?.patch?.small ?? "")!)
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
                self.missionIconImageView.image = image
            }
        }
    }
}
