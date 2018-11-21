//
//  SearchViewController+TableViewDelegate.swift
//  SearchApp
//
//  Created by Nagib Azad on 21/11/18.
//  Copyright © 2018 Nagib Bin Azad. All rights reserved.
//

import Foundation
import UIKit.UITableView

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarks.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookmarkCellIdentifier", for: indexPath)
        let bookmark = bookmarks[indexPath.row]
        cell.textLabel?.text = bookmark.title
        cell.detailTextLabel?.text = bookmark.pageUrl.absoluteString
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
