//
//  BookmarkViewController+TableViewDelegate.swift
//  SearchApp
//
//  Created by Nagib Azad on 22/11/18.
//  Copyright © 2018 Nagib Bin Azad. All rights reserved.
//

import Foundation
import UIKit

extension BookmarkViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarks.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "BookmarkTableViewCellIdentifier")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "BookmarkTableViewCellIdentifier")
        }
        let bookmark = bookmarks[indexPath.row]
        cell!.textLabel?.text = bookmark.title
        cell!.detailTextLabel?.text = bookmark.pageUrl.absoluteString
        return cell!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Bookmarks"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pageDetailsViewController = PageDetailsViewController.initializePageDetailsViewController(with: bookmarks[indexPath.row])
        let navigationController = UINavigationController(rootViewController: pageDetailsViewController)
        navigationController.transitioningDelegate = self.modalTransition
        self.present(navigationController, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
