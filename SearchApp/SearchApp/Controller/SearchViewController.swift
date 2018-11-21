//
//  SearchViewController.swift
//  SearchApp
//
//  Created by Nagib Azad on 20/11/18.
//  Copyright © 2018 Nagib Bin Azad. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    lazy var tapRecognizer: UITapGestureRecognizer = {
        var recognizer = UITapGestureRecognizer(target:self, action: #selector(dismissKeyboard))
        return recognizer
    }()
    var lastContentOffset: CGFloat = 0
    var searchResults: [Page] = []
    var bookmarks: [Bookmark] = []
    let queryService = QueryService()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BookmarkCellIdentifier")
    }

    func sendRequestForData() -> Void {
        if !searchBar.text!.isEmpty {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            queryService.getSearchResults(searchTerm: searchBar.text!) { results, errorMessage in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                if let results = results {
                    self.searchResults = results
                    self.collectionView.reloadData()
                }
                if !errorMessage.isEmpty { print("Search error: " + errorMessage) }
            }
        }
    }
    
    @IBAction func historyButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func bookmarkButoonPressed(_ sender: Any) {
        
    }
}

