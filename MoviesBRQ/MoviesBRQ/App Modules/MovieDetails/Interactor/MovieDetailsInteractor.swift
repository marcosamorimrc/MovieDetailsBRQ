//
//  MovieDetailsInteractor.swift
//  MoviesBRQ
//
//  Created by Marcos Amorim Rossi de Carvalho on 30/06/21.
//

import Foundation
import Alamofire

class MovieDetailsInteractor: MovieDetailsPresenterToInteractorProtocol{
    
    var presenter: MovieDetailsInteractorToPresenterProtocol?
    
    func fetchMovieDetails() {
        AF.request(URL_API_MOVIE_DETAILS)
            .responseJSON { (response) in
                switch response.result {
                                case .success(let value):
                                    //transforms result value into JSON
                                    if let JSON = value as? [String: Any] {
                                        //check if return is a success
                                        if let success = JSON["success"] {
                                            if !(success as! Bool) {
                                                self.presenter?.movieFetchFailed()
                                                return
                                            }
                                        }
                                        //return movie fetched
                                        if let movie = MovieDetails.init(object: JSON as NSDictionary){
                                            self.presenter?.movieFetchedSuccess(MovieDetails: movie)
                                        }
                                    }
                                case .failure(let error):
                                    print(error)
                                    self.presenter?.movieFetchFailed()
                                }
        }
    }
    
    func fetchMovieSimilar() {

        AF.request(URL_API_MOVIE_SIMILAR)
            .responseJSON { (response) in
                switch response.result {
                                case .success(let value):
                                    //transforms result value into JSON
                                    if let JSON = value as? [String: Any] {
                                        //check if return is a success
                                        if let success = JSON["success"] {
                                            if !(success as! Bool) {
                                                self.presenter?.movieFetchFailed()
                                                return
                                            }
                                        }
                                        //return array of similar movies
                                        if let arrayMovies = JSON["results"] as? NSArray{
                                            let movieList = NSMutableArray.init()
                                            for movie in arrayMovies {
                                                movieList.add(MovieDetails.init(object: movie as! NSDictionary)!)
                                            }
                                            self.presenter?.movieSimilarFetchedSuccess(MovieDetailsArray: movieList as! Array<MovieDetails>)
                                        }
                                    }
                                case .failure(let error):
                                    print(error)
                                    self.presenter?.movieFetchFailed()
                                }
        }
    }
    
    func fetchMovieGenres() {
        
        AF.request(URL_API_MOVIE_GENRES)
            .responseJSON { (response) in
                switch response.result {
                                case .success(let value):
                                    //transforms result value into JSON
                                    if let JSON = value as? [String: Any] {
                                        //check if return is a success
                                        if let success = JSON["success"] {
                                            if !(success as! Bool) {
                                                self.presenter?.movieGenresFetchFailed()
                                                return
                                            }
                                        }
                                        //return array of movie genres with ids
                                        if let arrayGenres = JSON["genres"] as? NSArray{
                                            self.presenter?.movieGenresFetchedSuccess(MovieGenresArray: arrayGenres)
                                        }
                                    }
                                case .failure(let error):
                                    print(error)
                                    self.presenter?.movieGenresFetchFailed()
                                }
        }
        
    }
    
}
