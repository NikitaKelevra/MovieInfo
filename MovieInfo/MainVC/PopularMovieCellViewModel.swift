//
//  PopularMoviesCellViewModel.swift
//  MovieInfo
//
//  Created by Сперанский Никита on 15.07.2022.
//

import UIKit

protocol PopularMovieCellViewModelProtocol {
    var movieImage: UIImage { get }
    var movieTitle: String { get }
    var movieReleaseDate: String { get }
    
    init(movie: Movie)
}

final class PopularMovieCellViewModel: PopularMovieCellViewModelProtocol {
    var movieImage: UIImage {
//        let url = URL(string: movie.posterPath)
        
        guard let image = ImageManager.shared.fetchImageData(from: movie.posterPath)
        else { return UIImage(systemName: "clock")!}       /// НЕБЕЗОПСНОЕ ИЗВЛЕЧЕНИЕ
        return image

    }
    
    var movieTitle: String {
        movie.originalTitle
    }
    
    var movieReleaseDate: String {
        movie.releaseDate
    }
    
    private let movie: Movie
    
    required init(movie: Movie) {
        self.movie = movie
    }
    
    
}
