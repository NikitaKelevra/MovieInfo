//
//  PopularTvShowsModel.swift
//  MovieInfo
//
//  Created by Сперанский Никита on 17.07.2022.
//

import Foundation

// MARK: - Popular TV Shows Model

struct PopularTvShows: Codable, Hashable {
    let page: Int
    let tvShows: [TvShow]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case tvShows = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct TvShow: Codable, Hashable {
    let posterPath: String
    let popularity: Double
    let id: Int
    let backdropPath: String
    let voteAverage: Double
    let overview, firstAirDate: String
    let originCountry: [OriginCountry]
    let genreIDS: [Int]
    let originalLanguage: OriginalLanguage
    let voteCount: Int
    let name, originalName: String

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case popularity, id
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case overview
        case firstAirDate = "first_air_date"
        case originCountry = "origin_country"
        case genreIDS = "genre_ids"
        case originalLanguage = "original_language"
        case voteCount = "vote_count"
        case name
        case originalName = "original_name"
    }
}

