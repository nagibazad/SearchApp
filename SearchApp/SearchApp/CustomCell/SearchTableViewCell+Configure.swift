//
//  SearchTableViewCell+Configure.swift
//  SearchApp
//
//  Created by Nagib Azad on 22/11/18.
//  Copyright © 2018 Nagib Bin Azad. All rights reserved.
//

import Foundation
import SDWebImage

extension SearchTableViewCell {
    func configure(with page: Page) -> Void {
        self.pageTitleLabel.text = page.title
        self.pageImageView.sd_setImage(with: page.imageUrl, placeholderImage: UIImage(named: "placeholder"), options: .retryFailed, completed: nil)
    }
}
