//
//  Welcome.swift
//  MovieInfo
//
//  Created by Сперанский Никита on 21.06.2022.
//

import Foundation

// MARK: - Welcome Screen
struct Welcome: Codable {
    let status: String
    let totalResults: Int?
    let articles: [Article]
}

struct Article: Codable {
    let source: Source?
    let author: String?
    let title, articleDescription: String
    let url: String
    let urlToImage: String?
    let publishedAt: Date
    let content: String

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}

struct Source: Codable {
    let id: String?
    let name: String
}

// MARK: - Popular Movie
struct PopularMovie:Codable {
    
}
