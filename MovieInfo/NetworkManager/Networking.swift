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
let language = "ru"
let urlTMDB = "https://api.themoviedb.org/3/movie/550?api_key=\(apiKey)&language=\(language)"

struct Networking {

    static let shared = Networking()
    
    //Функция загрузки стартовых данных страницы
    func fetch() {
        let urlSession = URLSession.shared //создаем экземпляр синглтона
        guard let url = URL(string: urlTMDB) else { return } // проверка на существование адреса
        
       urlSession.dataTask(with: url) { (data, response, error) in
           guard let data = data else { return }
           guard let response = response else { return }
           print(response)
           print(data)
            do {
//                let course = try JSONDecoder().decode(Course.self, from: data)
//                print(course)
                
            } catch let error {
                print(error)
                
            }
            
        }.resume()
    }
    
    
    
    
    
    
}
