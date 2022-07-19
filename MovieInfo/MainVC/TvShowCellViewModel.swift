//
//  TvShowCellViewModel.swift
//  MovieInfo
//
//  Created by Сперанский Никита on 15.07.2022.
//

import UIKit

protocol TvShowCellViewModelProtocol {
    var tvShowImage: UIImage { get }
    var tvShowTitle: String { get }
    var tvShowReleaseDate: String { get }
    
    init(tvShow: TvShow)
}

final class TvShowCellViewModel: TvShowCellViewModelProtocol {
    var tvShowImage: UIImage {
        let link = "https://image.tmdb.org/t/p/w500/\(tvShow.posterPath)"
        guard let image = ImageManager.shared.fetchImageData(from: link)
        else { return UIImage(systemName: "clock")!}       /// НЕБЕЗОПАСНОЕ ИЗВЛЕЧЕНИЕ
        return image
    }
    
    var tvShowTitle: String {
        tvShow.name
    }
    
    var tvShowReleaseDate: String{
        tvShow.firstAirDate
    }
    
    private let tvShow: TvShow
    
    init(tvShow: TvShow) {
        self.tvShow = tvShow
    }
    
    
}
