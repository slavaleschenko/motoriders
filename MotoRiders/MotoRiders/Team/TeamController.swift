//
//  TeamsTableViewController.swift
//  MotoRiders
//
//  Created by Admin on 21.06.18.
//  Copyright © 2018 SlavaLeschenko. All rights reserved.
//

import UIKit

class TeamController: UITableViewController {
    
    var teamData = [Team]()
    var service = TeamListService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        service.getTeamData { (teamData) in
            self.teamData = teamData
            self.tableView.reloadData()
        }
        self.navigationItem.title = "Moto GP teams"
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return teamData.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "teamNameCell", for: indexPath) as? TeamCell else {return UITableViewCell()}
        cell.teamName.text = teamData[indexPath.section].name
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if  segue.identifier == "ridersInTeam",
            let destination = segue.destination as? RidersInTeamController,
            let index = tableView.indexPathForSelectedRow?.section
        {
            destination.teamName = teamData[index].name
        }
    }
    

}
