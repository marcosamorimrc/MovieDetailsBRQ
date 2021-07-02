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
        AF.request(API_MOVIE_DETAILS)
            .responseJSON { (response) in
                switch response.result {
                                case .success(let value):
                                    if let JSON = value as? [String: Any] {
                                        if let success = JSON["success"] {
                                            if !(success as! Bool) {
                                                self.presenter?.movieFetchFailed()
                                            }
                                        }
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

        AF.request(API_MOVIE_SIMILAR)
            .responseJSON { (response) in
                switch response.result {
                                case .success(let value):
                                    if let JSON = value as? [String: Any] {
                                        if let success = JSON["success"] {
                                            if !(success as! Bool) {
                                                self.presenter?.movieFetchFailed()
                                            }
                                        }
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
        
        AF.request(API_MOVIE_GENRES)
            .responseJSON { (response) in
                switch response.result {
                                case .success(let value):
                                    if let JSON = value as? [String: Any] {
                                        if let success = JSON["success"] {
                                            if !(success as! Bool) {
                                                self.presenter?.movieGenresFetchFailed()
                                            }
                                        }
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
