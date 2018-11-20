//
//  PageCollectionViewCell+Configure.swift
//  SearchApp
//
//  Created by Nagib Azad on 20/11/18.
//  Copyright © 2018 Nagib Bin Azad. All rights reserved.
//

import Foundation

extension PageCollectionViewCell {
    
    func configureCell(with page: Page) -> Void {
        self.pageTitleLabel.text = page.title
    }
    
}
