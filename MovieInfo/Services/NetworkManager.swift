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
let popularTvShowsAPI = "https://api.themoviedb.org/3/tv/popular?api_key=\(apiKey)&language=\(language)&page=1"

enum UrlsTMDB: String {
    case popularMoviesAPI = "https://api.themoviedb.org/3/movie/popular?api_key=0edcf78b3ea519ebb0492575a839ee4e&language=ru-RUS&page=1"
    case popularTvShowsAPI = "https://api.themoviedb.org/3/tv/popular?api_key=0edcf78b3ea519ebb0492575a839ee4e&language=ru-RUS&page=1"
}


struct NetworkManager {

    static let shared = NetworkManager()
    private init() {}
    
    

    
    // MARK: -
    
    typealias RailCompletionClosure = ((PageModel?, Error?) -> Void)
    
    // Получаем данные из popularMoviesAPI
    public func fetchPopMovieData(completion: RailCompletionClosure?) {
        guard let request = createRequest(for: UrlsTMDB.popularMoviesAPI.rawValue) else {
            completion?(nil, NetworkError.invalidUrl)
            return
        }
        executeRequest(request: request, completion: completion)
    }
    
    // Получаем данные из popularTvShowsAPI
    public func fetchPopTvShowsData(completion: RailCompletionClosure?) {
        guard let request = createRequest(for: UrlsTMDB.popularTvShowsAPI.rawValue) else {
            completion?(nil, NetworkError.invalidUrl)
            return
        }
        executeRequest(request: request, completion: completion)
    }
    
    // Создаем настраиваем URLRequest из строки URL
    private func createRequest(for url: String) -> URLRequest? {
        guard let url = URL(string: url) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    // Выполняем сетевой запрос, используя URLRequest через URLSession
    private func executeRequest<T: Codable>(request: URLRequest, completion: ((T?, Error?) -> Void)?) {
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                completion?(nil, error)
                return
            }
            // Преобразовываем данные согласно поступившей модели данных
            if let decodedResponse = try? JSONDecoder().decode(T.self, from: data) {
                DispatchQueue.main.async {
                    completion?(decodedResponse, nil)
                }
            } else {
                completion?(nil, NetworkError.invalidData)
            }
        }
        dataTask.resume()
    }
    
}
    
// MARK: - Обработка ошибок интернет запросов
enum NetworkError: Error {
    case invalidUrl
    case invalidData
}
    
    
    // MARK: -
    
    /*
     
     

    //Get запрос c TMDB   ---  PopularMovies
    func fetchData(from url: String?, with complition: @escaping (PopularMovies) -> Void) {
        guard let stringURL = url else { return }
        guard let url = URL(string: stringURL) else { return }
        
        
        URLSession.shared.dataTask(with: url) { data, _, error in
                 
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else { return }
//            print(data)
            
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
    
    //Get запрос c TMDB   ---   popularTvShows
    func fetchDataTvShow(from url: String?, with complition: @escaping (PopularTvShows) -> Void) {
        guard let stringURL = url else { return }
        guard let url = URL(string: stringURL) else { return }
        
        
        URLSession.shared.dataTask(with: url) { data, _, error in
                 
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else { return }
            print("fetchDataTvShow - \(data)")
            
            do {
                let popularTvShows = try JSONDecoder().decode(PopularTvShows.self, from: data)
                DispatchQueue.main.async {
                    complition(popularTvShows)
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    
}

     */
