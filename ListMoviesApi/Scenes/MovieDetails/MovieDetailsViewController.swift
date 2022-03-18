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

final class MovieDetailsViewControllerImpl: UIViewController, MovieDetailsViewController {
    
    private let presenter: MovieDetailsPresenter
    private let activityView = UIActivityIndicatorView()
    private let titleLabel = UILabel()
    private let movieImageView = UIImageView()
    private let overviewLabel = UILabel()
    private let genreLabel = UILabel()
    private let scrollView = UIScrollView()
    private var vConstraints = [NSLayoutConstraint]()
    private var hConstraints = [NSLayoutConstraint]()
    private var defaultConstraint = [NSLayoutConstraint]()
    
    init(presenter: MovieDetailsPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        presenter.onViewAttached(controller: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityView.startAnimating()
        configureView()
        configureLayout()
    }
    
    func configure(movie: MovieDetails) {
        activityView.stopAnimating()
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        movieImageView.image = UIImage(data: movie.imageData)
        print(movie.genre)
    }
    
    private func configureView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        overviewLabel.textAlignment = .center
        overviewLabel.numberOfLines = 0
        
        movieImageView.layer.cornerRadius = 10
        movieImageView.clipsToBounds = true
        
        scrollView.backgroundColor = .systemBackground
    }
    
    private func configureLayout() {
        
        [scrollView, titleLabel, movieImageView, activityView, overviewLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        view.addSubview(scrollView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(movieImageView)
        scrollView.addSubview(activityView)
        scrollView.addSubview(overviewLabel)
        
        defaultConstraint.append(contentsOf: [
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            activityView.centerYAnchor.constraint(equalTo: movieImageView.centerYAnchor),
            activityView.centerXAnchor.constraint(equalTo: movieImageView.centerXAnchor),
            
            overviewLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            overviewLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            overviewLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 20),
            overviewLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
                         
        vConstraints.append(contentsOf: defaultConstraint)
        vConstraints.append(contentsOf: [
            
            titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            movieImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            movieImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            movieImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            movieImageView.widthAnchor.constraint(equalTo: movieImageView.heightAnchor),
        ])
        
        hConstraints.append(contentsOf: defaultConstraint)
        hConstraints.append(contentsOf: [
            
            movieImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            movieImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            movieImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            movieImageView.widthAnchor.constraint(equalTo: movieImageView.heightAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: movieImageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
        
        NSLayoutConstraint.activate( hConstraints )
        changeViewLayout(traitCollection: traitCollection)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        changeViewLayout(traitCollection: traitCollection, previousTraitCollection: previousTraitCollection)
    }
    
    private func changeViewLayout(traitCollection: UITraitCollection, previousTraitCollection: UITraitCollection? = nil) {
        guard traitCollection.horizontalSizeClass != previousTraitCollection?.horizontalSizeClass ||
                traitCollection.verticalSizeClass != previousTraitCollection?.verticalSizeClass else { return }
        
        switch(traitCollection.horizontalSizeClass, traitCollection.verticalSizeClass) {
        case (.compact, .regular): activateCompactLayout()
        default:                   activateRegularLayout()
        }
    }
    
    private func activateCompactLayout() {
        NSLayoutConstraint.deactivate(hConstraints)
        NSLayoutConstraint.activate(vConstraints)
    }
    
    private func activateRegularLayout() {
        NSLayoutConstraint.deactivate(vConstraints)
        NSLayoutConstraint.activate(hConstraints)
    }
}
