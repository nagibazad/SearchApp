//
//  SearchViewController+CollectionViewDelegate.swift
//  SearchApp
//
//  Created by Nagib Azad on 20/11/18.
//  Copyright © 2018 Nagib Bin Azad. All rights reserved.
//

import Foundation
import UIKit.UICollectionView

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: k_PageCollectionViewCellIdentifier, for: indexPath) as! PageCollectionViewCell
        cell.configureCell(with: searchResults[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    
}
