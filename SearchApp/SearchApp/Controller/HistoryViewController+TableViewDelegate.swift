//
//  HistoryViewController+TableViewDelegate.swift
//  SearchApp
//
//  Created by Nagib Azad on 22/11/18.
//  Copyright © 2018 Nagib Bin Azad. All rights reserved.
//

import Foundation
import UIKit.UITableView

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return histories.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCellIdentifier")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "HistoryTableViewCellIdentifier")
        }
        let history = histories[indexPath.row]
        cell!.textLabel?.text = history.title
        cell!.detailTextLabel?.text = history.pageUrl.absoluteString
        return cell!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Histories"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pageDetailsViewController = PageDetailsViewController.initializePageDetailsViewController(with: histories[indexPath.row])
        let navigationController = UINavigationController(rootViewController: pageDetailsViewController)
        navigationController.modalPresentationStyle = .overCurrentContext
        navigationController.modalTransitionStyle = .crossDissolve
        self.present(navigationController, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
