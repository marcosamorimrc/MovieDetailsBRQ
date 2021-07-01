//
//  MovieDetailsEntity.swift
//  MoviesBRQ
//
//  Created by Marcos Amorim Rossi de Carvalho on 30/06/21.
//

import Foundation

class MovieDetails{
    
    var title:String?
    var backdrop_path:String?
    var poster_path:String?
    var vote_count:Int?
    var popularity:Double?
    var release_date:String?
    var genres:NSArray?
    
    required init?(object:NSDictionary) {
        title = object["title"] as? String ?? ""
        backdrop_path = object["backdrop_path"] as? String ?? ""
        poster_path = object["poster_path"] as? String ?? ""
        vote_count = object["vote_count"] as? Int ?? 0
        popularity = object["popularity"] as? Double ?? 0
        release_date = object["release_date"] as? String ?? ""
        genres = object["genres"] as? NSArray ?? object["genre_ids"] as? NSArray ?? []
    }
    
}
