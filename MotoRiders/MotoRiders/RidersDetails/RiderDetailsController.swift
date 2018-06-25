//
//  RiderDetailsController.swift
//  MotoRiders
//
//  Created by Admin on 23.06.18.
//  Copyright © 2018 SlavaLeschenko. All rights reserved.
//

import UIKit

class RiderDetailsController: UITableViewController {
    
    var riderUid: String?
    
    var riderDetails = [RiderDetail]()
    
    var service = RiderDetailService()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
    }


    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    //TODO: - improve showing different cells:
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
           if let cell = tableView.dequeueReusableCell(withIdentifier: "image", for: indexPath) as? ImageCell {
//            DispatchQueue.global().async {
//                let imageString = self.riderDetails.first?.photoUrl
//                let imageUrl = URL(string: imageString!)
//                let imageData = NSData(contentsOf: imageUrl!)
//                DispatchQueue.main.async {
//                    cell.riderImage.image = UIImage(data: imageData! as Data)
//                }
//            }
            tableView.rowHeight = 220
            return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "name", for: indexPath) as? NameCell {
//                cell.riderName.text = riderDetails.first?.name
            tableView.rowHeight = 44
            return cell
            }
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
}
