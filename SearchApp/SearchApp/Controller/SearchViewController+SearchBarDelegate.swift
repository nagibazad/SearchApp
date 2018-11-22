//
//  SearchViewController+SearchBarDelegate.swift
//  SearchApp
//
//  Created by Nagib Azad on 20/11/18.
//  Copyright © 2018 Nagib Bin Azad. All rights reserved.
//

import Foundation
import UIKit

extension SearchViewController: UISearchBarDelegate {

  @objc func dismissKeyboard() {
    searchBar.resignFirstResponder()
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    dismissKeyboard()
    searchResults.removeAll()
    queryService.pages.removeAll()
    collectionView.isHidden = false
    tableView.isHidden = true
    collectionView.reloadData()
    sendRequestForData()
  }
  
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            searchResults.removeAll()
            queryService.pages.removeAll()
            collectionView.reloadData()
            collectionView.isHidden = true
            tableView.isHidden = false
            fetchBookmarks()
        }
    }
    
  func position(for bar: UIBarPositioning) -> UIBarPosition {
    return .topAttached
  }
  
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    view.addGestureRecognizer(tapRecognizer)
  }
  
  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    view.removeGestureRecognizer(tapRecognizer)
  }
}
