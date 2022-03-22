//
//  ThemeUserDefaults.swift
//  ListMoviesApi
//
//  Created by pavel mishanin on 21.03.2022.
//

import Foundation

extension UserDefaults {
    
    var theme: Theme {
        get {
            Theme(rawValue: UserDefaults.standard.integer(forKey: "selectedTheme")) ?? .device
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: "selectedTheme")
        }
    }
}
