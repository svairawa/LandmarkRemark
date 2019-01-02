//
//  ViewControllerTableViewCell.swift
//  LandmarkRemark
//
//  Created by Amric Edwards on 31/12/18.
//  Copyright © 2018 Shanya Vairawanathan. All rights reserved.
//

import UIKit

class ViewControllerTableViewCell: UITableViewCell {

    @IBOutlet weak var lblUser: UILabel!
    @IBOutlet weak var lblNote: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
