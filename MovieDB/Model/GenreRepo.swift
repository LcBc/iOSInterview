//
//  Genre + Utils.swift
//  MovieDB
//
//  Created by Luis Barrios on 9/28/18.
//  Copyright © 2018 Luis Barrios. All rights reserved.
//

import Foundation
import CoreData

class GenreRepository {
    
    class func parseAndUpdate(JSON jsonData: Any?, inManagedObjectContext context: NSManagedObjectContext)->Genre?{
        
        if let jsonData = jsonData as? [String: Any],
            let id = jsonData["id"] as? Int,
            let name =  jsonData["name"] as? String {
            let genre: Genre
            let request: NSFetchRequest<Genre> = NSFetchRequest(entityName: "Genre")
            request.predicate = NSPredicate(format: "id = %d", id)
            if let fetchedGenre = (try? context.fetch(request as! NSFetchRequest<NSFetchRequestResult>))?.first as? Genre {
                genre = fetchedGenre
            }else{
                genre  = Genre(context: context)
            }
            
          //  let genre = GenreDTO() // Genre(context: context)
            genre.id = Int64(id)
            genre.name = name
            return  genre 
        }
        
        return nil
        
    }
    
    class func fetch(byId: Int,inManagedObjectContext context: NSManagedObjectContext)->Genre? {
        
        let request: NSFetchRequest<Genre> = NSFetchRequest(entityName: "Genre")
        request.predicate = NSPredicate(format: "id = %d", byId)
        if let newGenre = (try? context.fetch(request as! NSFetchRequest<NSFetchRequestResult>))?.first as? Genre {
            return newGenre
        }
        return nil
        
    }
    
    
}
