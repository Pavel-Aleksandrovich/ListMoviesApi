//
//  CustomBarButtonItem.swift
//  ListMoviesApi
//
//  Created by pavel mishanin on 22.03.2022.
//

import UIKit

final class CustomBarButtonItem: UIBarButtonItem {
    
    private var viewController: UIViewController! = nil
    private var sortComplitionHandler: ((SortState) -> ())! = nil
    
    func createSortingButton(
        viewController: UIViewController,
        sortComplitionHandler: @escaping((SortState) -> ())) {
        
        self.viewController = viewController
        self.sortComplitionHandler = sortComplitionHandler
        
        createBarButtonItem()
    }

    private func createBarButtonItem() {
        let sortingButton = UIBarButtonItem(title: "Sorting by: Random", style: .done, target: self, action: #selector(showSortingAlert))
        viewController.navigationItem.rightBarButtonItem = sortingButton
    }
    
    @objc private func showSortingAlert() {
        let alert = UIAlertController(title: "Sorting by:", message: nil, preferredStyle: .actionSheet)
        
        let photoLibraryAction = UIAlertAction(title: "Id", style: .default) {_ in
            self.sortComplitionHandler(.id)
        }
        let cameraAction = UIAlertAction(title: "Title", style: .default) {_ in
            self.sortComplitionHandler(.title)
        }
        let randomAction = UIAlertAction(title: "Random", style: .default) {_ in
            self.sortComplitionHandler(.random)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(photoLibraryAction)
        alert.addAction(cameraAction)
        alert.addAction(randomAction)
        alert.addAction(cancelAction)
        
        viewController.present(alert, animated: true)
    }
}

