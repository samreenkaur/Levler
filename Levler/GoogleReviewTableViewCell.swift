//
//  GoogleReviewTableViewCell.swift
//  Levler
//
//  Created by Mohak on 26/09/17.
//  Copyright © 2017 Mohak. All rights reserved.
//

import UIKit

class GoogleReviewTableViewCell: UITableViewCell {

  //  @IBOutlet weak var readmore: UIButton!
    @IBOutlet weak var gimg: UIImageView!
    @IBOutlet weak var gname: UILabel!
    @IBOutlet weak var grate: UILabel!
    @IBOutlet weak var gdes: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
