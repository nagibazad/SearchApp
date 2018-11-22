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
        if searchBar.text?.isEmpty == true {
            return bookmarks.count
        }
        return searchResults.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if searchBar.text?.isEmpty == true {
            return 44.0
        }
        return 54.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if searchBar.text?.isEmpty == true {
            var cell = tableView.dequeueReusableCell(withIdentifier: "BookmarkCellIdentifier")
            if cell == nil {
                cell = UITableViewCell(style: .subtitle, reuseIdentifier: "BookmarkCellIdentifier")
            }
            let bookmark = bookmarks[indexPath.row]
            cell!.textLabel?.text = bookmark.title
            cell!.detailTextLabel?.text = bookmark.pageUrl.absoluteString
            return cell!
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: k_SearchTableViewCellIdentifier, for: indexPath) as! SearchTableViewCell
            let page = searchResults[indexPath.row]
            cell.configure(with: page)
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if searchBar.text?.isEmpty == true {
            return "Bookmarks"
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pageDetailsViewController = PageDetailsViewController.initializePageDetailsViewController(with: searchBar.text?.isEmpty == true ? bookmarks[indexPath.row]: searchResults[indexPath.row])
        let navigationController = UINavigationController(rootViewController: pageDetailsViewController)
        navigationController.modalPresentationStyle = .overCurrentContext
        navigationController.modalTransitionStyle = .crossDissolve
        self.present(navigationController, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
