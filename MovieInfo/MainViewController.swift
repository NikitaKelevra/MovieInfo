//
//  MainViewController.swift
//  MovieInfo
//
//  Created by Сперанский Никита on 20.06.2022.
//

import UIKit

class MainViewController: UICollectionViewController {
    
    typealias DataSourse = UICollectionViewDiffableDataSource<Section, Film>
    typealias Snapshot = NSDiffableDataSourceSnapshot<popularMovies, Product>
    
    // MARK: - Properties
    private var popularMovies: PopularMovies?
    
    
    
    private var viewModel: MainViewModelProtocol! {
        didSet {
            viewModel.fetchPopularMovies {
                self.reloadData()
            }
        }
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = MainViewModel()
        
//        fetchData(from: popularMovieAPI)
        setupCollectionView()
    }
    
    // MARK: -

    
    // MARK: - Private func

    
    /// Перезагружает данные в CollectionView
    private func reloadData() {
        var snapshot = Snapshot()
        snapshot.appendSections(viewModel.popularMovies)
        for section in viewModel.popularMovies {
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
    
    // MARK: - Diffable Data Source
    private func createDataSourse() {
        /// Настраивает ячейки в зависимости от секции
        dataSourse = DataSourse(collectionView: collectionView,
                                cellProvider: { [self] (collectionView, indexPath, _) -> UICollectionViewCell? in
            let section = viewModel.productsList[indexPath.section].section
            
            switch section {
            case .mainMenu:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MainMenuCell.self), for: indexPath) as! MainMenuCell
                
                cellBuilder.configureCell(for: cell,
                                          with: viewModel.mainMenuCellViewModel(with: indexPath))
                return cell
            case .specialOffers:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SpecialOfferCell.self), for: indexPath) as! SpecialOfferCell
                
                cellBuilder.configureCell(for: cell,
                                          with: viewModel.specialOfferCellViewModel(with: indexPath))
                return cell
            }
        })
        
    
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

