//
//  PageDetailsViewController.swift
//  SearchApp
//
//  Created by Nagib Azad on 21/11/18.
//  Copyright © 2018 Nagib Bin Azad. All rights reserved.
//

import UIKit
import WebKit
import CoreData

class PageDetailsViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    private var selectedPage: Page!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    class func initializePageDetailsViewController(with page:Page) -> PageDetailsViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let pageDetailsViewController = storyboard.instantiateViewController(withIdentifier: "PageDetailsViewControllerID") as! PageDetailsViewController
        pageDetailsViewController.selectedPage = page
        return pageDetailsViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = UIColor.black
        let bookmarkButton = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(bookmarkButtonPressed))
        navigationItem.rightBarButtonItem = bookmarkButton
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleTapGesture.numberOfTapsRequired = 2
        doubleTapGesture.delegate = self
        webView.addGestureRecognizer(doubleTapGesture)
        webView.navigationDelegate = self
        webView.load(URLRequest(url: selectedPage.pageUrl))
        saveHistry()
        
    }
    
    @objc func bookmarkButtonPressed() {
        saveBookmark()
    }
    
    func saveHistry() -> Void {
        
        let privateContext = CoreDataHandler.sharedInstance.privateManagedObjectContext()!
        let history = CoreDataHandler.insertNewManagedObject(forEntityName: "History", inManagedObjectContext: privateContext) as! History
        history.title = selectedPage.title
        history.imageUrl = selectedPage.imageUrl
        history.pageUrl = selectedPage.pageUrl
        history.pageId = Int64(selectedPage.pageId)
        history.time = NSDate()
        CoreDataHandler.sharedInstance.saveDataAsynchronusly(inManagedObjectContext: privateContext) { (success, error) in
            if success == true{
                print("History saved Suceessfully")
            }
        }
    }
    
    func saveBookmark() -> Void {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Bookmark")
        fetchRequest.predicate = NSPredicate(format: "pageId = \(selectedPage.pageId)")
        fetchRequest.fetchLimit = 1
        CoreDataHandler.sharedInstance.fetchObjectAsynchronusly(withFetchRequest: fetchRequest) {[weak self](result, error) in
            if let strongSelf = self {
                let privateContext = CoreDataHandler.sharedInstance.privateManagedObjectContext()!
                var bookmark: Bookmark!
                if let result = result, result.count > 0 {
                    print("Already bookmarked")
                }else {
                    bookmark = CoreDataHandler.insertNewManagedObject(forEntityName: "Bookmark", inManagedObjectContext: privateContext) as? Bookmark
                    bookmark.title = strongSelf.selectedPage.title
                    bookmark.imageUrl = strongSelf.selectedPage.imageUrl
                    bookmark.pageUrl = strongSelf.selectedPage.pageUrl
                    bookmark.pageId = Int64(strongSelf.selectedPage.pageId)
                }
                CoreDataHandler.sharedInstance.saveDataAsynchronusly(inManagedObjectContext: privateContext) { (success, error) in
                    if success == true{
                        print("Suceess")
                    }
                }
            }
        }
    }
    
    @objc func handleDoubleTap() -> Void {
        dismiss(animated: true, completion: nil)
    }
    
}

extension PageDetailsViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
}

extension PageDetailsViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
