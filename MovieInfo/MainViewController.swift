//
//  MainViewController.swift
//  MovieInfo
//
//  Created by Сперанский Никита on 20.06.2022.
//

import UIKit

class MainViewController: UICollectionViewController {

    private var popularMovies: PopularMovies?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        fetchData(from: popularMovieAPI)
        setupCollectionView()
    }

    private func fetchData(from url: String?) {
        NetworkManager.shared.fetchData(from: url) {  popularMovies in
            print (popularMovies)
            self.popularMovies = popularMovies
//            self.tableView.reloadData()
        }
    }
    
    
    
    
    // MARK: - Setup Collection View
    // Основные настройки Collection View
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    // MARK: - CollectionViewCompositionalLayout
    // Создаем композиционный Layout для разных секций коллекции
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let section = self.viewModel.productsList[sectionIndex]

            switch section.section {
            case .mainMenu:
                return self.createMainMenuSection()
            case .specialOffers:
                return self.createSpecialOfferSection()
            }
        }
        return layout
    }
}

