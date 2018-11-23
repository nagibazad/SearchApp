//
//  BookmarkViewController.swift
//  SearchApp
//
//  Created by Nagib Azad on 22/11/18.
//  Copyright © 2018 Nagib Bin Azad. All rights reserved.
//

import UIKit
import CoreData

class BookmarkViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var bookmarks: [Page] = []
    var modalTransition: CustomModalTransitionDelegate = CustomModalTransitionDelegate()

    class func initializeBookmarkViewController() -> BookmarkViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let bookmarkViewController = storyboard.instantiateViewController(withIdentifier: "BookmarkViewControllerID") as! BookmarkViewController
        return bookmarkViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Bookmarks"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchBookmarks()
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

}
