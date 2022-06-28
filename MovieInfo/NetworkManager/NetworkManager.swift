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
let language = "en-US"
let region = "RU"

let urlTMDB = "https://api.themoviedb.org/3/movie/550?api_key=\(apiKey)&language=\(language)"
let popularMovieAPI = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=\(language)&page=1&region=\(region)"




struct NetworkManager {

    static let shared = NetworkManager()
    private init() {}
    
    //Get запрос популярных фильмов
    func fetchData(from url: String?, with complition: @escaping (PopularMovie) -> Void) {
        guard let stringURL = url else { return }
        guard let url = URL(string: stringURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let popularMovie = try JSONDecoder().decode(PopularMovie.self, from: data)
                DispatchQueue.main.async {
                    complition(popularMovie)
                }
            } catch let error {
                print(error)
            }
            
        }.resume()
    }
    
//    func getPopularMovie() {
//        guard let url = URL(string: popularMovieAPI) else { print("no url"); return }
//        
//        guard let popularMovie = try? JSONEncoder().encode(course) else { return }
//        
//       URLSession.shared.dataTask(with: url) { data, response, error in
//            // Проверка на наличие ошибок
//           guard error == nil else { print ("error: \(error!)"); return }
//           
//            // Проверка, что данные пришли
//           guard let data = data else { print("No data"); return }
//
//           guard let response = response else { return }
//           
//           print(response)
//           print(data)
//            
//            do {
//                let popularMovieArray = try JSONDecoder().decode(PopularMovie.self, from: data)
//                print(popularMovieArray)
//                
//            } catch let error {
//                print ("error: \(error)")
//            }
//        }
//    }
//    
    //GET запрос стартовых данных страницы
    func fetch() {
//        guard let url = URL(string: urlTMDB) else { return } // проверка на существование адреса
//        
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//           guard let data = data else { return }
//           guard let response = response else { return }
//           print(response)
//           print(data)
//            do {
////                let course = try JSONDecoder().decode(Course.self, from: data)
////                print(course)
//                
//            } catch let error {
//                print(error)
//                
//            }
//            
//        }.resume()
    }
    
    
    
    
    
}
