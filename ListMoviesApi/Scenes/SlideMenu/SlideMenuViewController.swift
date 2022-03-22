//
//  SlideMenuViewController.swift
//  ListMoviesApi
//
//  Created by pavel mishanin on 21.03.2022.
//

import UIKit

final class SlideMenuViewController: UIViewController {
    
    private let tableView = UITableView()
    private var table: SlideTable!
    private let personImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTableView()
        configureLayer()
        configureConstraints()
        configureImageViewAction()
    }
    
    private func createTableView() {
        table = SlideTableImpl(tableView: tableView, onCellTappedClosure: { result in
            switch result {
            case .home:
                print("home")
            case .settings:
                print("settings")
            }
        })
    }
    
    private func configureImageViewAction() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(pickImage))
        personImageView.addGestureRecognizer(gesture)
    }
    
    @objc func pickImage(_ sender: UITapGestureRecognizer) {
        print("pickImage")
    }
    
    private func configureLayer() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        personImageView.translatesAutoresizingMaskIntoConstraints = false
        
        personImageView.layer.cornerRadius = 10
        personImageView.clipsToBounds = true
        personImageView.layer.borderWidth = 2
        personImageView.layer.borderColor = UIColor.white.cgColor
        personImageView.isUserInteractionEnabled = true
        
        view.backgroundColor = .gray
        view.addSubview(tableView)
        view.addSubview(personImageView)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            
            personImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            personImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            personImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            personImageView.widthAnchor.constraint(equalTo: personImageView.heightAnchor),
            
            tableView.topAnchor.constraint(equalTo: personImageView.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
