//
//  MoviesCell.swift
//  ListMoviesApi
//
//  Created by pavel mishanin on 14.03.2022.
//

import UIKit

final class MoviesCell: UITableViewCell {
    
    private enum Constants {
        static let imageLeading: CGFloat = 10
        static let titleLeading: CGFloat = 10
        static let titleHeight: CGFloat = 30
    }
    
    private let image = UIImageView()
    private let titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureView()
        configureLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(note: Result) {
        titleLabel.text = note.title
    }
}

private extension MoviesCell {
    
    func configureView() {
        image.clipsToBounds = true
        image.layer.cornerRadius = self.bounds.height/2
        
        [image, titleLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addSubview(image)
        addSubview(titleLabel)
    }
    
    func configureLayoutConstraints() {
        
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.imageLeading),
            image.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            image.widthAnchor.constraint(equalToConstant: self.bounds.height),
            image.heightAnchor.constraint(equalToConstant: self.bounds.height),
            
            titleLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: Constants.titleLeading),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: Constants.titleHeight),
            titleLabel.widthAnchor.constraint(equalToConstant: self.bounds.width/2),
        ])
    }
}

