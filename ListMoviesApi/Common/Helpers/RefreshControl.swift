//
//  RefreshControl.swift
//  ListMoviesApi
//
//  Created by pavel mishanin on 14.03.2022.
//

import UIKit

final class RefreshControl {
    
    private let refreshControl = UIRefreshControl()
    private var tableView: UITableView
    
    init(tableView: UITableView) {
        self.tableView = tableView
        refreshActrion()
    }
    
    private func refreshActrion() {
        refreshControl.attributedTitle = NSAttributedString(string: "Download")
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc private func refresh(_ refreshControl: UIRefreshControl) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        refreshControl.endRefreshing()
    }
}
