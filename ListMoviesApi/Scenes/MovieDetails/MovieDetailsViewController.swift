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
    private let favoriteImageView = UIImageView()
    private let deleteImageView = UIImageView()
    private let pokemonImageView = UIImageView()
    
    var deleteOrFavoriteClosure: ((DeleteOrFavorite) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
        configureLayout()
        configureActions()
        activityView.startAnimating()
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
        
        favoriteImageView.image = UIImage(systemName: "heart") //heart.fill
        favoriteImageView.isUserInteractionEnabled = true
        favoriteImageView.contentMode = .scaleAspectFit
        
        deleteImageView.image = UIImage(systemName: "trash")
        deleteImageView.contentMode = .scaleAspectFit
        deleteImageView.isUserInteractionEnabled = true
    }
    
    private func configureActions() {
        
        let favorite = UITapGestureRecognizer(target: self, action: #selector(addToFavorite))
        favoriteImageView.addGestureRecognizer(favorite)
        
        let trash = UITapGestureRecognizer(target: self, action: #selector(deleteFromFavorite))
        deleteImageView.addGestureRecognizer(trash)
    }
    
    @objc func addToFavorite(_ sender: UITapGestureRecognizer) {
        deleteOrFavoriteClosure?(.favorite)
    }
    
    @objc func deleteFromFavorite(_ sender: UITapGestureRecognizer) {
        deleteOrFavoriteClosure?(.delete)
    }
    
    private func configureLayout() {
        
        [titleLabel, favoriteImageView, deleteImageView, pokemonImageView, activityView].forEach {
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
            
            favoriteImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            favoriteImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            favoriteImageView.heightAnchor.constraint(equalToConstant: 60),
            favoriteImageView.widthAnchor.constraint(equalToConstant: 60),
            
            deleteImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deleteImageView.topAnchor.constraint(equalTo: favoriteImageView.bottomAnchor, constant: 20),
            deleteImageView.heightAnchor.constraint(equalToConstant: 60),
            deleteImageView.widthAnchor.constraint(equalToConstant: 60),
            
            activityView.centerYAnchor.constraint(equalTo: pokemonImageView.centerYAnchor),
            activityView.centerXAnchor.constraint(equalTo: pokemonImageView.centerXAnchor),
            
        ])
    }
}
