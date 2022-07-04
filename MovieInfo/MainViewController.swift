//
//  MainViewController.swift
//  MovieInfo
//
//  Created by Сперанский Никита on 20.06.2022.
//

import UIKit

class MainViewController: UICollectionViewController {

    
    
    // MARK: - Properties
    private var popularMovies: PopularMovies?
    
    
    
    private var viewModel: MainViewModelProtocol! {
        didSet {
            viewModel.fetchFilms {
                self.reloadData()
            }
        }
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = MainViewModel()
        
        fetchData(from: popularMovieAPI)
        setupCollectionView()
    }
    
    // MARK: -

    
    // MARK: - Private func

    
    /// Перезагружает данные в CollectionView
    private func reloadData() {
        var snapshot = Snapshot()
        snapshot.appendSections(viewModel.productsList)
        for section in viewModel.productsList {
            snapshot.appendItems(section.items, toSection: section)
        }
        dataSourse?.apply(snapshot)
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

