//
//  MovieDetailsPresenter.swift
//  MoviesBRQ
//
//  Created by Marcos Amorim Rossi de Carvalho on 30/06/21.
//

import Foundation
import UIKit

class MovieDetailsPresenter: MovieDetailsViewToPresenterProtocol {
    
    var view: MovieDetailsPresenterToViewProtocol?
    
    var interactor: MovieDetailsPresenterToInteractorProtocol?
    
    var router: MovieDetailsPresenterToRouterProtocol?
    
    func fetchMovieInfo() {
        interactor?.fetchMovieDetails()
        interactor?.fetchMovieSimilar()
    }
    
    func fetchMovieGenres() {
        interactor?.fetchMovieGenres()
    }
    
}

extension MovieDetailsPresenter: MovieDetailsInteractorToPresenterProtocol{
    
    func movieFetchedSuccess(MovieDetails: MovieDetails) {
        view?.showInfo(movieInfo: MovieDetails)
    }
    
    func movieFetchFailed() {
        view?.showError()
    }
    
    func movieSimilarFetchedSuccess(MovieDetailsArray: Array<MovieDetails>) {
        view?.showSimilar(movieArray: MovieDetailsArray)
    }
    
    func movieSimilarFetchFailed() {
        view?.showError()
    }
    
    func movieGenresFetchedSuccess(MovieGenresArray: NSArray) {
        view?.setMovieGenres(MovieGenresArray: MovieGenresArray)
    }
    
    func movieGenresFetchFailed() {
        view?.showError()
    }
    
}
