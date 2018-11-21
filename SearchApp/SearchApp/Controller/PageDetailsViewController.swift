//
//  PageDetailsViewController.swift
//  SearchApp
//
//  Created by Nagib Azad on 21/11/18.
//  Copyright © 2018 Nagib Bin Azad. All rights reserved.
//

import UIKit
import WebKit

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
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleTapGesture.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(doubleTapGesture)
        webView.navigationDelegate = self
        webView.load(URLRequest(url: selectedPage.pageUrl))
        // Do any additional setup after loading the view.
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
