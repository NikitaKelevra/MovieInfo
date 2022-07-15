//
//  MainViewController.swift
//  MovieInfo
//
//  Created by Сперанский Никита on 20.06.2022.
//

import UIKit
// MARK: Основной экран VC
class MainViewController: UICollectionViewController {
    
//    typealias dataSourсe = UICollectionViewDiffableDataSource<Section, Movie>
    typealias Snapshot = NSDiffableDataSourceSnapshot<MoviesList, Movie>
    
    // MARK: - Properties
    
    private var dataSource: UICollectionViewDiffableDataSource<MoviesList, Movie>?
    
    private var popularMovies: PopularMovies?
    private var cellBuilder: CellBuildable!  // создание строителя ячеек
    
    private var viewModel: MainViewModelProtocol! {
        didSet {
            viewModel.fetchMovies {
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
    
    
    // MARK: - Private func

    
    /// Перезагружает данные в CollectionView
    private func reloadData() {
        var snapshot = Snapshot()
        snapshot.appendSections(viewModel.moviesList)
        for section in viewModel.popularMoviesList {
            snapshot.appendItems(section.items, toSection: section)
        }
        dataSource?.apply(snapshot)
    }
    
    
    

    // MARK: - Setup Collection View
    // Основные настройки Collection View
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    // MARK: - Diffable Data Source
    private func createDataSource() {
        // Настройка ячеек секциий для каждой секции
        // инициализируем dataSource
        dataSource = UICollectionViewDiffableDataSource<MoviesList, Movie>(collectionView: collectionView,
                                                                        cellProvider: { (collectionView, indexPath, movie) -> UICollectionViewCell?
            in
            
            let sectionType = self.viewModel.moviesList[indexPath.section].typeOfSection
            // строим ячейки в зависимости от типа секции
            switch sectionType {
            case .popularMovie:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PopularMovieCell.self),
                                                              for: indexPath) as! PopularMovieCell
                
                self.cellBuilder.configureCell(for: cell, with: self.viewModel.popularMovieCellViewModel(with: indexPath))
                return cell
            case .tvShow:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TvShowCell.self),
                                                              for: indexPath) as! TvShowCell
                
                self.cellBuilder.configureCell(for: cell, with: self.viewModel.tvShowCellViewModel(with: indexPath))
                return cell
            }
        })
        
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

