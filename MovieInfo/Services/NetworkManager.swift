//
//  Network Manager.swift
//  MovieInfo
//
//  Created by Сперанский Никита on 20.06.2022.
//

import Foundation

// https://stackoverflow.com/questions/62396033/tmdb-api-call-swift
// Ключ API (v3 auth)  0edcf78b3ea519ebb0492575a839ee4e
// Пример API-запроса   https://api.themoviedb.org/3/movie/550?api_key=0edcf78b3ea519ebb0492575a839ee4e

let apiKey = "0edcf78b3ea519ebb0492575a839ee4e" //Ключ API (v3 auth)
let language = "ru-RUS"
let region = "RU"

let urlTMDB = "https://api.themoviedb.org/3/movie/550?api_key=\(apiKey)&language=\(language)"
let popularMoviesAPI = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=\(language)&page=1" //&region=\(region)




struct NetworkManager {

    static let shared = NetworkManager()
    private init() {}
    
    //Get запрос популярных фильмов
    func fetchData(from url: String?, with complition: @escaping (PopularMovies) -> Void) {
        guard let stringURL = url else { return }
        guard let url = URL(string: stringURL) else { return }
        
        
        URLSession.shared.dataTask(with: url) { data, response, error in
                 
            if let error = error {
                print(error)
                return
            }
//            print(response)
            
            guard let data = data else { return }
            print(data)
            
            do {
                let popularMovie = try JSONDecoder().decode(PopularMovies.self, from: data)
                DispatchQueue.main.async {
                    complition(popularMovie)
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
}
