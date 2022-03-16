//
//  MovieDetailsViewController.swift
//  ListMoviesApi
//
//  Created by pavel mishanin on 15.03.2022.
//

import UIKit

enum DeleteOrFavorite {
    case delete
    case favorite
}

final class MovieDetailsViewControllerImpl: UIViewController {
    
    private let activityView = UIActivityIndicatorView()
    private let titleLabel = UILabel()
    private let pokemonImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityView.startAnimating()
        configureView()
        configureLayout()
    }
    
    func configure(pokemon: Result) {
        DispatchQueue.main.async {
            self.titleLabel.text = pokemon.title
            print(pokemon.posterPath)
            self.activityView.stopAnimating()
            self.loadPokemonPhotoBy(url: pokemon.posterPath) { data in
                self.pokemonImageView.image = UIImage(data: data)
            }
        }
    }
    
    func loadPokemonPhotoBy(url: String, completed: @escaping(Data) -> ()) {
        let imageURL = URL(string: "https://image.tmdb.org/t/p/original" + url)!
        
        DispatchQueue.global(qos: .utility).async {
            if let data = try? Data(contentsOf: imageURL) {
                DispatchQueue.main.async {
                    completed(data)
                }
            }
        }
    }
    
    private func configureView() {
        view.backgroundColor = .white
    }
    
    private func configureLayout() {
        
        [titleLabel, pokemonImageView, activityView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            pokemonImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pokemonImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            pokemonImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            pokemonImageView.widthAnchor.constraint(equalTo: pokemonImageView.heightAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: pokemonImageView.bottomAnchor, constant: 20),
            
            activityView.centerYAnchor.constraint(equalTo: pokemonImageView.centerYAnchor),
            activityView.centerXAnchor.constraint(equalTo: pokemonImageView.centerXAnchor),
            
        ])
    }
}
