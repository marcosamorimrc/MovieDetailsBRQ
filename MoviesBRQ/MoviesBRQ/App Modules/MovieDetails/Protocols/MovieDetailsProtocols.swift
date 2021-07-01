//
//  MovieDetailsProtocols.swift
//  MoviesBRQ
//
//  Created by Marcos Amorim Rossi de Carvalho on 30/06/21.
//

import Foundation
import UIKit

protocol MovieDetailsViewToPresenterProtocol: AnyObject {
    
    var view: MovieDetailsPresenterToViewProtocol? {get set}
    var interactor: MovieDetailsPresenterToInteractorProtocol? {get set}
    var router: MovieDetailsPresenterToRouterProtocol? {get set}
    func fetchMovieInfo()
    func fetchMovieGenres()

}

protocol MovieDetailsPresenterToViewProtocol: AnyObject {
    func showInfo(movieInfo:MovieDetails)
    func showSimilar(movieArray:Array<MovieDetails>)
    func setMovieGenres(MovieGenresArray:NSArray)
    func showError()
}

protocol MovieDetailsPresenterToRouterProtocol: AnyObject {
    static func createModule()-> MovieDetailsView
}

protocol MovieDetailsPresenterToInteractorProtocol: AnyObject {
    var  presenter:MovieDetailsInteractorToPresenterProtocol? {get set}
    func fetchMovieDetails()
    func fetchMovieSimilar()
    func fetchMovieGenres()
}

protocol MovieDetailsInteractorToPresenterProtocol: AnyObject {
    func movieFetchedSuccess(MovieDetails:MovieDetails)
    func movieFetchFailed()
    func movieSimilarFetchedSuccess(MovieDetailsArray:Array<MovieDetails>)
    func movieSimilarFetchFailed()
    func movieGenresFetchedSuccess(MovieGenresArray:NSArray)
    func movieGenresFetchFailed()
    
}
