//
//  MainViewModel.swift
//  MovieInfo
//
//  Created by Сперанский Никита on 04.07.2022.
//

import UIKit

// MARK: - MainViewModelProtocol
protocol MainViewModelProtocol {
    
//    var updateMainViewData: ((MainViewData) -> ())? { get set }
    
    var popularMovies: [Result] { get }
    
//    var filmsImage: [UIImage] { get }
//    var filmsTitle: [String] { get }
    
    func numberOfRowsPopularMovies() -> Int
    
    func fetchPopularMovies(completion: @escaping() -> Void)
    
}

// MARK: - MainViewModel
    
final class MainViewModel: MainViewModelProtocol {
    
//    public var updateMainViewData: ((MainViewData) -> ())?
    
//    init() {
//        updateMainViewData?(.initial)
//    }
    
    var popularMovies: [Result] = []
    
//    var popularMoviesTitle: [String] {
//        popularMoviesResult.originalTitle
//    }
//
//    var popularMoviesImage: [UIImage] {
//        popularMoviesResult.backdropPath
//    }
    
    func numberOfRowsPopularMovies() -> Int {
        print("Количество популярных фильмов будет \(popularMoviesResult.count)")
        return popularMoviesResult.count
    }
    
    
    func fetchPopularMovies(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchData(from: popularMoviesAPI) {  popularMovies in
            print (popularMovies.results)
            self.popularMoviesResult = popularMovies.results
        }
    }
    
    
    
    // MARK: - Private func
    private func fetchData(from url: String?) {
        NetworkManager.shared.fetchData(from: url) {  popularMovies in
            print (popularMovies.results)
        }
    }
    
}




