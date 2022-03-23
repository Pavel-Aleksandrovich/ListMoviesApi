//
//  MovieSettingsViewController.swift
//  ListMoviesApi
//
//  Created by pavel mishanin on 22.03.2022.
//

import UIKit

final class MovieSettingsViewController: UIViewController {
    
    private let themeSwitch = UISwitch()
    private let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureLayout()
        configureSwitchActions()
        chooseTheme()
    }
    
    private func configureSwitchActions() {
        themeSwitch.addTarget(self, action: #selector(numberValueChanged), for: .valueChanged)
    }
    
    @objc func numberValueChanged() {
        
        if themeSwitch.isOn {
            configureDark()
            UserDefaults.standard.theme = .dark
        } else {
            configureLight()
            UserDefaults.standard.theme = .light
        }
        
        view.window?.overrideUserInterfaceStyle =  UserDefaults.standard.theme.getUserInterfaceStyle()
    }
    
    private func chooseTheme() {
        switch UserDefaults.standard.theme {
        case .dark:
            configureDark()
            themeSwitch.isOn = true
        case .device:
            configureDark()
            themeSwitch.isOn = true
        case .light:
            configureLight()
            themeSwitch.isOn = false
        }
    }
    
    private func configureDark() {
        themeSwitch.onTintColor = .gray
        themeSwitch.thumbTintColor = .white
        label.text = "dark"
    }
    
    private func configureLight() {
        themeSwitch.thumbTintColor = .black
        label.text = "light"
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        
        [themeSwitch, label].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        view.addSubview(themeSwitch)
        view.addSubview(label)
    }
    
    private func configureLayout() {
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            themeSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            themeSwitch.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
}
