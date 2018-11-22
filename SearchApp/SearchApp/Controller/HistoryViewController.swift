//
//  HistoryViewController.swift
//  SearchApp
//
//  Created by Nagib Azad on 22/11/18.
//  Copyright © 2018 Nagib Bin Azad. All rights reserved.
//

import UIKit
import CoreData

class HistoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var histories: [Page] = []
    
    class func initializeHistoryViewController() -> HistoryViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let historyViewController = storyboard.instantiateViewController(withIdentifier: "HistoryViewControllerID") as! HistoryViewController
        return historyViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "History"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchHistory()
    }
    
    func fetchHistory() -> Void {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "History")
        CoreDataHandler.sharedInstance.fetchObjectAsynchronusly(withFetchRequest: fetchRequest) {[weak self](result, error) in
            if let strongSelf = self {
                strongSelf.histories.removeAll()
                result?.forEach({ (managedObject) in
                    if let historyManagedObject = managedObject as? History {
                        strongSelf.histories.append(Page(title: historyManagedObject.title!, pageId: Int(historyManagedObject.pageId), pageUrl: historyManagedObject.pageUrl!, imageUrl:historyManagedObject.imageUrl))
                    }
                })
                DispatchQueue.main.async {
                    strongSelf.tableView.reloadData()
                }
            }
        }
    }
}
