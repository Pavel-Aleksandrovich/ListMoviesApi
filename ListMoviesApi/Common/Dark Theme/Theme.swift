//
//  Theme.swift
//  ListMoviesApi
//
//  Created by pavel mishanin on 21.03.2022.
//

import UIKit

enum Theme: Int {
    case device
    case light
    case dark
    
    func getUserInterfaceStyle() -> UIUserInterfaceStyle {
        
        switch self {
        case .device:
            return .dark
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}
