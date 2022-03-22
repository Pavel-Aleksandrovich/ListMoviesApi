//
//  SlideTable.swift
//  ListMoviesApi
//
//  Created by pavel mishanin on 22.03.2022.
//

import UIKit

enum HamburgerLayer: String, CaseIterable {
    case home = "Home"
    case settings = "Settings"
    
    var iconName: String {
        switch self {
        case .home: return "house"
        case .settings: return "gear"
        }
    }
}

protocol SlideTable {
}

final class SlideTableImpl: NSObject, SlideTable, UITableViewDelegate, UITableViewDataSource {
    
    private enum Constants {
        static let cellIdentifier = "UITableViewCell"
        static let heightForRow: CGFloat = 60
    }
    
    private let tableView: UITableView
    private let onCellTappedClosure: (HamburgerLayer) -> ()
    
    init(tableView: UITableView, onCellTappedClosure: @escaping (HamburgerLayer) -> ()) {
        self.tableView = tableView
        self.onCellTappedClosure = onCellTappedClosure
        super.init()
        configureTableView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = HamburgerLayer.allCases[indexPath.row].rawValue
        cell.imageView?.image = UIImage(systemName: HamburgerLayer.allCases[indexPath.row].iconName)
        
        cell.backgroundColor = .gray
        cell.imageView?.tintColor = .white
        cell.textLabel?.textColor = .white
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HamburgerLayer.allCases.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.heightForRow
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let item = HamburgerLayer.allCases[indexPath.row]
        onCellTappedClosure(item)
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .gray
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
    }
}


