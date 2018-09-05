//
//  OrganizationTableViewCell.swift
//  HSEday
//
//  Created by Anton Danilov on 26.08.2018.
//  Copyright © 2018 Anton Danilov. All rights reserved.
//

import UIKit

class OrganizationTableViewCell: UITableViewCell {

    @IBOutlet weak var orgName: UILabel!
    @IBOutlet weak var orgImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
