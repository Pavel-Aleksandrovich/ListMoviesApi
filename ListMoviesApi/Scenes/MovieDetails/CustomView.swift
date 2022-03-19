//
//  CustomView.swift
//  ListMoviesApi
//
//  Created by pavel mishanin on 19.03.2022.
//

import UIKit

final class CustomView: UIImageView {
    
    func setImageUrl(url: String) {
        let imageURL = URL(string: url)!
        
        DispatchQueue.global(qos: .utility).async {
            if let data = try? Data(contentsOf: imageURL) {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
        }
    }
}
