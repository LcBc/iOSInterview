//
//  MovieRequestManager.swift
//  MovieDB
//
//  Created by Luis Barrios on 9/28/18.
//  Copyright © 2018 Luis Barrios. All rights reserved.
//

import Foundation
import Alamofire

enum Category:String {
    case popular = "popular"
    case upcoming = "upcoming"
    case topRated = "top_rated"
}

let apiKey = "1f920402d85d0610fbd3f3051a7c21c5"
let movieRequestBase = "https://api.themoviedb.org/3/movie/"
let genreRequestBase = "https://api.themoviedb.org/3/genre/movie/list"
let posterBaseURL = "https://image.tmdb.org/t/p/original"

class MovieRequestManager {
    
    //https://api.themoviedb.org/3/genre/movie/list?api_key=1f920402d85d0610fbd3f3051a7c21c5&language=en-US
    //https://api.themoviedb.org/3/movie/latest?api_key=1f920402d85d0610fbd3f3051a7c21c5
    //https://api.themoviedb.org/3/movie/upcoming?api_key=1f920402d85d0610fbd3f3051a7c21c5
    //https://api.themoviedb.org/3/movie/top_rated?api_key=1f920402d85d0610fbd3f3051a7c21c5
    // https://api.themoviedb.org/pEFRzXtLmxYNjGd0XqJDHPDFKB2.jpg
    //http://image.tmdb.org/t/p/original/pEFRzXtLmxYNjGd0XqJDHPDFKB2.jpg
    
    

    
    
    
    static func fetchMovies(in category: Category, page: Int = 1 ,completion: @escaping (Any?) -> Void) {
        guard let url = URL(string: movieRequestBase + category.rawValue) else{
            completion(nil)
            return
        }
        
        Alamofire.request(url,
                          method: .get, parameters:["api_key":apiKey, "language": "en-US", "page":page],encoding: URLEncoding.default)
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess else {
                   
                    completion(nil)
                    return
                }
                guard let value = response.result.value as? [String: Any] else {
                    completion(nil)
                    return
                }
                
              completion(value)
                
//                 if  let rows = value["results"] as? [[String: Any]] {
//                     completion(rows)
//                 }
//                 } else  if let rows = value[""] as? [[String: Any]]{
//                    completion(rows)
//                }
                
        }
    }
    
    static func fetchCategories(completion: @escaping ([Any]?)-> Void) {
        guard let url = URL(string: genreRequestBase) else{
            completion(nil)
            return
        }
        Alamofire.request(url,
                          method: .get, parameters:["api_key":apiKey],encoding: URLEncoding.default)
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess else {
                    completion(nil)
                    return
                }
                guard let value = response.result.value as? [String: Any],
                    let rows = value["genres"] as? [[String: Any]] else {
                        completion(nil)
                        return
                }
               // print(rows)
                completion(rows)
        }
        
        
        
        
    }
    
}
