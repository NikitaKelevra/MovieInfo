//
//  MoviesModel.swift
//  MovieInfo
//
//  Created by Сперанский Никита on 21.06.2022.
//

import Foundation

// MARK: - Type of Section CollectionView
struct MoviesList: Hashable {
    let typeOfSection: Section
    let items: [Movie]
}

enum Section: String, CaseIterable {
    case popularMovie = "Popular Movie"
    case tvShow = "TV Show"
}


// MARK: - Popular Movies Model
struct PopularMovies: Codable, Hashable {
    let page: Int
    let movies: [Movie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case movies = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Movie: Codable, Hashable {
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originalLanguage: OriginalLanguage
    let originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case es = "es"
}

// MARK: - Состояния MainView

enum MainViewData {
    case initial
    case loading([Movie])
    case success([Movie])
    case failure([Movie])
}







// MARK: - Welcome Screen- Не используется
//struct Welcome: Codable {
//    let status: String
//    let totalResults: Int?
//    let articles: [Article]
//}
//
//struct Article: Codable {
//    let source: Source?
//    let author: String?
//    let title, articleDescription: String
//    let url: String
//    let urlToImage: String?
//    let publishedAt: Date
//    let content: String
//
//    enum CodingKeys: String, CodingKey {
//        case source, author, title
//        case articleDescription = "description"
//        case url, urlToImage, publishedAt, content
//    }
//}
//
//struct Source: Codable {
//    let id: String?
//    let name: String
//}