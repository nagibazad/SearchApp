//
//  SearchViewController+ScrollDelegate.swift
//  SearchApp
//
//  Created by Nagib Azad on 21/11/18.
//  Copyright © 2018 Nagib Bin Azad. All rights reserved.
//

import Foundation
import UIKit.UIScrollView

extension SearchViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let _ = scrollView as? UITableView {
            let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
            if bottomEdge >= scrollView.contentSize.height {
                // we are at the end
                if searchBar.text?.isEmpty == false {
                    sendRequestForData()
                }
            }
            if (self.lastContentOffset > scrollView.contentOffset.y) {
                // move up
                print("move up")
            }
            else if (self.lastContentOffset < scrollView.contentOffset.y) {
                // move down
                print("move down")
                
            }
            
            // update the new position acquired
            self.lastContentOffset = scrollView.contentOffset.y
        }
        
    }
    
}
