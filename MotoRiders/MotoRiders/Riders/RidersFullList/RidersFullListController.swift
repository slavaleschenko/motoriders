//
//  RidersFullListController.swift
//  MotoRiders
//
//  Created by Admin on 25.06.18.
//  Copyright © 2018 SlavaLeschenko. All rights reserved.
//

import UIKit

class RidersFullListController: UITableViewController {
    
    var riders = [Riders]()
    var service = RidersListService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        service.getFullListRiders { (riders) in
            self.riders = riders
            self.tableView.rowHeight = 100
            self.tableView.reloadData()
        }
        self.navigationItem.title = "Moto GP riders"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return riders.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ridersListCell", for: indexPath) as? RidersFullListCell else {return UITableViewCell()}
        
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
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if  segue.identifier == "riderDetailsFromFullList",
            let destination = segue.destination as? RiderDetailsController,
            let index = tableView.indexPathForSelectedRow?.section
        {
            destination.riderUid = riders[index].uid
        }
    }
    
}
