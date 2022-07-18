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
//    typealias Snapshot = NSDiffableDataSourceSnapshot<MoviesList, Movie>
    
    // MARK: - Properties
    
    private var dataSource: UICollectionViewDiffableDataSource<MoviesList, Movie>?
    
    private var popularMovies: PopularMovies?
    private var cellBuilder: CellBuilderProtocol!  // создание строителя ячеек
    
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
        
//        NetworkManager.shared.fetchData(from: popularTvShowsAPI) { popularMovies in
//            print(popularMovies)
//        }
        
//        fetchData(from: popularMovieAPI)
        setupCollectionView()
        createDataSource()
        reloadData()
    }
    
    // MARK: - Init
    init() {
        super.init(collectionViewLayout: UICollectionViewLayout())
        cellBuilder = CellBuilder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private func

    

    
    

    // MARK: - Setup Collection View
    // Основные настройки Collection View
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor =  .brown // .systemGroupedBackground
        
        collectionView.register(PopularMovieCell.self, forCellWithReuseIdentifier: String(describing: PopularMovieCell.self))
        collectionView.register(TvShowCell.self, forCellWithReuseIdentifier: String(describing: TvShowCell.self))
        
        view.addSubview(collectionView)
    }
    
    // MARK: - Diffable Data Source
    private func createDataSource() {
        // Настройка ячеек секциий для каждой секции
        // UICollectionViewDiffableDataSource говорит какая секция отвечает за какой тип ячеек [без заполнения]
        dataSource = UICollectionViewDiffableDataSource<MoviesList, Movie>(collectionView: collectionView,
                                                                        cellProvider: { (collectionView, indexPath, movie) -> UICollectionViewCell?
            in
            
            let sectionType = self.viewModel.moviesList[indexPath.section].section
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

    // Перезагружает данные в CollectionView
    // NSDiffableDataSourceSnapshot заполняет данными ячейки каждой секции
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<MoviesList, Movie>()
//        var snapshot = Snapshot()
        ///добавляем секции в секцию
        snapshot.appendSections(viewModel.moviesList)
        /// в каждую определенную секцию добавляем items
        for section in viewModel.moviesList {
            snapshot.appendItems(section.items, toSection: section)
        }
        ///добавляет подготовленный snapshot в dataSource
        ///чтобы приложение видело какие данные отображать
        dataSource?.apply(snapshot,animatingDifferences: true)
    }
    
        
    
    // MARK: - CollectionViewCompositionalLayout
    // Создаем композиционный Layout для разных секций коллекции
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let section = self.viewModel.moviesList[sectionIndex]

            switch section.section {
            case .popularMovie:
                return self.createPopularMovieSection()
            case .tvShow:
                return self.createTvShowSection()
            }
        }
        return layout
    }
    
    
    /// Создаем `layout` для секции `Popular Movie`
    /// Позже необходимо сделать одну функцию с передачей типа секции
    private func createPopularMovieSection() -> NSCollectionLayoutSection {
        /// Создание и настройка `элемента` в группе
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 0,
                                                          leading: 16,
                                                          bottom: 16,
                                                          trailing: 16)
        
        /// Настройка `группы` в секции
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(150))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                     subitems: [item])
        
        /// Настройка секции
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 10,
                                                             leading: 0,
                                                             bottom: 10,
                                                             trailing: 0)
        
        /// Добавление заголовка
        let header = createSectionHeader()
        section.boundarySupplementaryItems = [header]

        return section
    }
    
    /// Создаем `layout` для секции `TV Show`
    func createTvShowSection() -> NSCollectionLayoutSection {
        let padding: CGFloat = 16
        let widthDimension: CGFloat = (view.bounds.width - padding) / 3
        
        /// Настройка `элемента` в группе
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets.init(top: 10,
                                                                leading: padding,
                                                                bottom: 10,
                                                                trailing: 0)
        
        /// Настройка `группы` в секции
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .estimated(widthDimension),
                                                     heightDimension: .estimated(widthDimension * 1.25))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize,
                                                             subitems: [layoutItem])
        
        /// Настройка секции
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .continuous
        layoutSection.contentInsets = NSDirectionalEdgeInsets.init(top: 0,
                                                                   leading: 0,
                                                                   bottom: 0,
                                                                   trailing: 0)
        return layoutSection
    }
    
    /// Создаем `Заголовок` секции
    func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                             heightDimension: .estimated(50))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize,
                                                                              elementKind: UICollectionView.elementKindSectionHeader,
                                                                              alignment: .top)
        return layoutSectionHeader
    }
}
