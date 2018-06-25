//
//  RidersInTeamController.swift
//  MotoRiders
//
//  Created by Admin on 21.06.18.
//  Copyright © 2018 SlavaLeschenko. All rights reserved.
//

import UIKit

class RidersInTeamController: UITableViewController {
    var riders = [Riders]()
    var service = RidersListService()
    var teamName: String?

    @IBOutlet weak var noRidersLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        service.getRidersData(team: teamName!) { (riders) in
            self.riders = riders
            self.tableView.rowHeight = 100
            self.tableView.reloadData()
        }
        self.tabBarController?.tabBar.isHidden = true
        self.navigationItem.title = self.teamName
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return riders.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ridersForSelectedTeam", for: indexPath) as? RiderNameCell else {return UITableViewCell()}
        if riders.isEmpty == false {
            cell.riderName.text = riders[indexPath.section].name
            cell.riderNumber.text = riders[indexPath.section].number
            DispatchQueue.global().async {
                let imageString = self.riders[indexPath.section].photoUrl
                let imageUrl = URL(string: imageString)
                let imageData = NSData(contentsOf: imageUrl!)
                DispatchQueue.main.async {
                    cell.riderImage.image = UIImage(data: imageData! as Data)
                }
            }
            noRidersLabel.isHidden = true
        } else {
            cell.isHidden = true
            noRidersLabel.isHidden = false
        }
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if  segue.identifier == "riderDetails",
            let destination = segue.destination as? RiderDetailsController,
            let index = tableView.indexPathForSelectedRow?.section
        {
            destination.riderUid = riders[index].uid
        }
    }
}
