//
//  MainViewModel.swift
//  MovieInfo
//
//  Created by Сперанский Никита on 04.07.2022.
//

import Foundation
import UIKit

// MARK: - MainViewModelProtocol
protocol MainViewModelProtocol {
    
    var popularMoviesResult: [Result] { get }
    
    var filmsImage: [UIImage] { get }
    
    var filmsTitle: [String] { get }
    
    func numberOfRows() -> Int
    
    func fetchFavoriteFilms(completion: @escaping() -> Void)
    
}

// MARK: - MainViewModel
    
final class MainViewModel: MainViewModelProtocol {
    
    var popularMoviesResult: [Result] = []
    
    var filmsTitle: [String] {
        popularMoviesResult.originalTitle
    }
    
    var filmsImage: [UIImage] {
        popularMoviesResult.backdropPath
    }
    
    func numberOfRows() -> Int {
        print("Количество популярных фильмов будет \(popularMoviesResult.count)")
        return popularMoviesResult.count
    }
    
    
    func fetchFavoriteFilms(completion: @escaping () -> Void) {
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




