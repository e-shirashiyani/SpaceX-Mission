//
//  MissionListViewController+Ext.swift
//  SpaceX-Mission
//
//  Created by e.shirashiyani on 7/15/23.
//
import UIKit
extension MissionListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Display only the missions for the current page
        return currentPage * 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MissionCell", for: indexPath) as! MissionTableViewCell
        // Calculate the index for the current page
        if missions.count > 0 {
            let index = (currentPage - 1) * 20 + indexPath.row
            let mission = missions[index]
            cell.configure(with: mission)
        }
        return cell
    }
}

extension MissionListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = (currentPage - 1) * 20 + indexPath.row
        let selectedMission = missions[index]
        didSelectMission(selectedMission)
    }
}
