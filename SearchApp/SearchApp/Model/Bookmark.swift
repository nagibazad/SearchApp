
//
//  Bookmark.swift
//  SearchApp
//
//  Created by Nagib Azad on 21/11/18.
//  Copyright © 2018 Nagib Bin Azad. All rights reserved.
//

import Foundation

class Bookmark {
    var title: String
    var pageUrl: URL
    init(title: String, pageUrl: URL) {
        self.title = title
        self.pageUrl = pageUrl
    }
    
}
