//
//  SearchViewController.swift
//  SearchApp
//
//  Created by Nagib Azad on 20/11/18.
//  Copyright © 2018 Nagib Bin Azad. All rights reserved.
//

import UIKit
import CoreData

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBarTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    lazy var tapRecognizer: UITapGestureRecognizer = {
        var recognizer = UITapGestureRecognizer(target:self, action: #selector(dismissKeyboard))
        return recognizer
    }()
    var searchResults: [Page] = []
    var bookmarks: [Page] = []
    let queryService = QueryService()
    var isAnimating: Bool = false
    var isAnimatingSearchBar: Bool = false
    var offsetChanged: Int = 0
    
    class func initializeSearchViewController() -> SearchViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let searchViewController = storyboard.instantiateViewController(withIdentifier: "SearchViewControllerID") as! SearchViewController
        return searchViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAdditionalUI()
        fetchBookmarks()
    }

    func sendRequestForData() -> Void {
        if !searchBar.text!.isEmpty {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            queryService.getSearchResults(searchTerm: searchBar.text!) { results, errorMessage in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                if let results = results {
                    self.searchResults = results
                    self.tableView.reloadData()
                }
                if !errorMessage.isEmpty { print("Search error: " + errorMessage) }
            }
        }
    }
    
    func fetchBookmarks() -> Void {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Bookmark")
        CoreDataHandler.sharedInstance.fetchObjectAsynchronusly(withFetchRequest: fetchRequest) {[weak self](result, error) in
            if let strongSelf = self {
                strongSelf.bookmarks.removeAll()
                result?.forEach({ (managedObject) in
                    if let bookmarkManagedObject = managedObject as? Bookmark {
                        strongSelf.bookmarks.append(Page(title: bookmarkManagedObject.title!, pageId: Int(bookmarkManagedObject.pageId), pageUrl: bookmarkManagedObject.pageUrl!, imageUrl:bookmarkManagedObject.imageUrl))
                    }
                })
                DispatchQueue.main.async {
                    strongSelf.tableView.reloadData()
                }
            }
        }
    }
    
    func setupAdditionalUI() -> Void {
        if let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView {
            let statusbarView = UIView(frame: statusBar.frame)
            statusbarView.backgroundColor = UIColor(red: (247/255), green: (247/255), blue: (247/255), alpha: 1)
            self.view.addSubview(statusbarView)
        }
    }
}
