//
//  PageCollectionViewCell+Configure.swift
//  SearchApp
//
//  Created by Nagib Azad on 20/11/18.
//  Copyright © 2018 Nagib Bin Azad. All rights reserved.
//

import Foundation
import SDWebImage

extension PageCollectionViewCell {
    
    func configureCell(with page: Page) -> Void {
        self.pageImageView.sd_setImage(with: page.imageUrl, placeholderImage: UIImage(named: "placeholder"), options: .continueInBackground, completed: nil)
        self.pageTitleLabel.text = page.title
    }
    
}
