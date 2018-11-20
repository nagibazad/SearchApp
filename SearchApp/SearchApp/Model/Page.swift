//
//  Page.swift
//  SearchApp
//
//  Created by Nagib Azad on 20/11/18.
//  Copyright © 2018 Nagib Bin Azad. All rights reserved.
//

import Foundation

class Page {
    
    var title: String
    var pageId: Int
    var pageUrl: URL
    var imageUrl: URL?
    
    init(title: String, pageId: Int, pageUrl: URL, imageUrl: URL?) {
        self.title = title
        self.pageId = pageId
        self.pageUrl = pageUrl
        self.imageUrl = imageUrl
    }
    
}
