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
            if scrollView.contentOffset.y < 20 {
                changeSearchBar(hidden: false, animated: false)
                changeTabBar(hidden: false, animated: false)
            }
            else if bottomEdge >= scrollView.contentSize.height {
                if searchBar.text?.isEmpty == false {
                    sendRequestForData()
                }
            }
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            changeTabBar(hidden: false, animated: true)
            changeSearchBar(hidden: true, animated: true)
        }else{
            changeTabBar(hidden: true, animated: true)
            changeSearchBar(hidden: false, animated: true)
        }
        
    }
    
    func changeSearchBar(hidden: Bool, animated: Bool) -> Void {
        if self.isAnimatingSearchBar == true {
            return
        }
        let duration:TimeInterval = (animated ? 0.5 : 0.0)
        let searchBarConstant = hidden ?  -(searchBar.frame.origin.y + searchBar.frame.height) : 0.0
        if searchBar.isHidden == hidden {
            return
        }
        self.isAnimatingSearchBar = true
        if hidden == false {
            searchBar.isHidden = hidden
        }
        UIView.animate(withDuration: duration, animations: {
            self.searchBarTopConstraint.constant = searchBarConstant
            self.view.layoutIfNeeded()
        }, completion: { (finished) in
            self.searchBar.isHidden = hidden
            self.isAnimatingSearchBar = false
        })
    }
    
    func changeTabBar(hidden:Bool, animated: Bool){
        if self.isAnimating == true {
            return
        }
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        guard let tabBar = appdelegate.tabBarController?.tabBar else { return; }
        if tabBar.isHidden == hidden{ return }
        var frame = tabBar.frame
        let height = frame.size.height
        frame.origin.y = hidden ?  frame.origin.y + height : frame.origin.y - height
        let duration:TimeInterval = (animated ? 0.5 : 0.0)
        let constant = hidden ? -frame.size.height : 0.0
        
        self.isAnimating = true
        if hidden == false {
            tabBar.isHidden = hidden
        }
        UIView.animate(withDuration: duration, animations: {
            self.tableViewBottomConstraint.constant = constant
            self.view.layoutIfNeeded()
            tabBar.frame = frame
        }, completion: { (finished) in
            tabBar.isHidden = hidden
            self.isAnimating = false
        })
    }
}
