//
//  SearchTableViewCell.swift
//  SearchApp
//
//  Created by Nagib Azad on 22/11/18.
//  Copyright © 2018 Nagib Bin Azad. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var pageImageView: UIImageView!
    @IBOutlet weak var pageTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
