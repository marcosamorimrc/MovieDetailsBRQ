//
//  AppConstants.swift
//  MoviesBRQ
//
//  Created by Marcos Amorim Rossi de Carvalho on 30/06/21.
//

import Foundation

//Get API_KEY from TMDB.plist
let path = Bundle.main.path(forResource: "TMDB", ofType: "plist")
let plist = NSDictionary(contentsOfFile: path!)
let API_KEY:String = "?api_key=" + (plist?.object(forKey: "API_KEY") as? String)!

let URL_API_MOVIE_DETAILS:String = "https://api.themoviedb.org/3/movie/600354\(API_KEY)"
let URL_API_MOVIE_SIMILAR:String = "https://api.themoviedb.org/3/movie/600354/similar\(API_KEY)"
let URL_API_MOVIE_IMAGES:String = "https://image.tmdb.org/t/p/w500/"
let URL_API_MOVIE_GENRES:String = "https://api.themoviedb.org/3/genre/movie/list\(API_KEY)"

