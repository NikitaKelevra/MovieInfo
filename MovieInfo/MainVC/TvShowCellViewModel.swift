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
        guard let image = ImageManager.shared.fetchImageData(from: tvShow.posterPath)
        else { return UIImage(systemName: "clock")!}       /// НЕБЕЗОПСНОЕ ИЗВЛЕЧЕНИЕ
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
