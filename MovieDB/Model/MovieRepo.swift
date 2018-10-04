//
//  MovieRepo.swift
//  MovieDB
//
//  Created by Luis Barrios on 9/28/18.
//  Copyright © 2018 Luis Barrios. All rights reserved.
//

import Foundation
import CoreData
//["vote_count": 0,
//"backdrop_path": /z0ScQLvf1He5n6qvEkR8lmHQgxz.jpg,
//"adult": 0,
//"title": Lifechanger,
//"vote_average": 0,
//"poster_path": /nkcoJycpOJAEsiWNEytXNirEmDx.jpg,
//"release_date": 2018-10-01,
//"popularity": 24.839,
//"overview": A murderous shapeshifter sets out on a blood-soaked mission to make things right with the woman he loves.,
//"genre_ids": <__NSArray0 0x6000029d40c0>(
//
//)
//, "id": 532645,
//"original_language": en,
//"video": 0,
//"original_title": Lifechanger]


class  MovieRepository {
    
    
    class func parseAndUpdate(JSON jsonData: Any?, inManagedObjectContext context: NSManagedObjectContext, with category: Category? = nil)->Movie?{
        
        
        if let jsonData = jsonData as? [String: Any],let id = jsonData["id"] as? Int
            {
                
        let request: NSFetchRequest<Genre> = NSFetchRequest(entityName: "Movie")

                let movie: Movie
                request.predicate = NSPredicate(format: "id = %d", id)
                if let cachedMovie = (try? context.fetch(request as! NSFetchRequest<NSFetchRequestResult>))?.first as? Movie {
                            movie = cachedMovie
                }else{
                    movie = Movie(context: context)
                }
                movie.id = Int32(id)
                if let title =  jsonData["title"] as? String {
                    movie.title = title
                }
                if let vote_count = jsonData["vote_count"] as? Int{
                    movie.vote_count = Int32(vote_count)
                }
                if  let adult = jsonData["adult"] as? Bool {
                        movie.adult = adult
                }
                if let backdrop_path = jsonData["backdrop_path"] as? String {
                    movie.backdrop_path = backdrop_path
                }
                if let vote_average = jsonData["vote_average"] as? Double {
                    movie.vote_average = vote_average
                }
                if  let poster_path = jsonData["poster_path"] as? String {
                    movie.poster_path = poster_path
                }
                if let release_date = jsonData["release_date"] as? Date {
                    movie.release_date = release_date
                }
                if let popularity = jsonData["popularity"] as? Double {
                    movie.popularity = popularity
                }
                if let overview = jsonData["overview"] as? String {
                    movie.overview = overview
                }
                if  let original_language = jsonData["original_language"] as? String {
                    movie.original_language = original_language
                }
                if let original_title = jsonData["original_title"] as? String{
                    movie.original_title = original_title
                }
                if let video = jsonData["video"] as? Bool {
                    movie.video = video
                }
                if let genreIDS = jsonData["genre_ids"] as? [Int] {
                 let genre =  genreIDS.compactMap{
                        GenreRepository.fetch(byId: $0, inManagedObjectContext: context)
                    }
                    movie.genres = (NSSet(array: genre))
//                  movie.genres?.addingObjects(from: genre)
                }
                
                if let category = category {
                    movie.category = category.rawValue
                }
                            
            return  movie
        
        }
        return nil
        
    }
    
    class func fetchAll(in category: Category, inManagedObjectContext context:NSManagedObjectContext ) -> [Movie]?{
       
        let request: NSFetchRequest<Genre> = NSFetchRequest(entityName: "Movie")
        request.predicate = NSPredicate(format: "category = %@", category.rawValue)
        guard let movies = (try? context.fetch(request as! NSFetchRequest<NSFetchRequestResult>)) as? [Movie] else {
           return nil
        }
        return movies
    }
    
    
}
