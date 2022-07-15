//
//  MainViewModel.swift
//  MovieInfo
//
//  Created by Сперанский Никита on 04.07.2022.
//

import UIKit

// MARK: - MainViewModelProtocol
protocol MainViewModelProtocol {
    
    var moviesList: [MoviesList] { get }
    var popularMoviesList: [Movie] { get }
    var tvShowsList: [Movie] { get }
    
    func numberOfRowsPopularMovies() -> Int
    
    // запросы от API массивов фильмов и ТВ
    func fetchMovies(completion: @escaping() -> Void)
    
    //    var updateMainViewData: ((MainViewData) -> ())? { get set }
    
    // Создание ячеек для секций
    func popularMovieCellViewModel(with indexPath: IndexPath) -> PopularMovieCellViewModelProtocol
    func tvShowCellViewModel(with indexPath: IndexPath) -> TvShowCellViewModelProtocol
}

// MARK: - MainViewModel
    
final class MainViewModel: MainViewModelProtocol {
    
   
    var moviesList: [MoviesList] = []
    
    var popularMoviesList: [Movie] = []
    var tvShowsList: [Movie] = []
    
    
    func numberOfRowsPopularMovies() -> Int {
        print("Количество популярных фильмов будет \(popularMoviesList.count)")
        return popularMoviesList.count
    }
    
    
    func fetchMovies(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchData(from: popularMoviesAPI) {  popularMovies in
            print (popularMovies.movies)
            self.popularMoviesList = popularMovies.movies
        }
    }
    
    // Реализация создания ячеек для секций через протоколы View моделей
    func popularMovieCellViewModel(with indexPath: IndexPath) -> PopularMovieCellViewModelProtocol {
        let movie = popularMoviesList[indexPath.row]
        return PopularMovieCellViewModel(movie: movie)
    }
    
    func tvShowCellViewModel(with indexPath: IndexPath) -> TvShowCellViewModelProtocol {
        let movie = tvShowsList[indexPath.row]
        return TvShowCellViewModel(movie: movie)
    }
    
    
    
    
    //    public var updateMainViewData: ((MainViewData) -> ())?
    
    //    init() {
    //        updateMainViewData?(.initial)
    //    }
    
    
    // MARK: - Private func
    private func fetchData(from url: String?) {
        NetworkManager.shared.fetchData(from: url) {  popularMovies in
            print (popularMovies.movies)
        }
    }
    
}




