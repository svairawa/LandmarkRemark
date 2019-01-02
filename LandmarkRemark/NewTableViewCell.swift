//
//  NewTableViewCell.swift
//  
//
//  Created by Shanya Vairawanathan on 2/1/19.
//

import UIKit

class NewTableViewCell: UITableViewCell {
    
    //Creating the outlets for the labels
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
