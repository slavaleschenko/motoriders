//
//  RiderNameCell.swift
//  MotoRiders
//
//  Created by Admin on 21.06.18.
//  Copyright © 2018 SlavaLeschenko. All rights reserved.
//

import UIKit

class RiderNameCell: UITableViewCell {

    @IBOutlet weak var riderImage: UIImageView!
    
    @IBOutlet weak var riderName: UILabel!
    
    @IBOutlet weak var riderNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
