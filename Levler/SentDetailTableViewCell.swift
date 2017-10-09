//
//  SentDetailTableViewCell.swift
//  Levler
//
//  Created by Mohak on 28/09/17.
//  Copyright © 2017 Mohak. All rights reserved.
//

import UIKit

class SentDetailTableViewCell: UITableViewCell {

    
   // @IBOutlet weak var sno: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var contact: UILabel!
    @IBOutlet weak var time: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
