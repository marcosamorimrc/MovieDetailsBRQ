//
//  MovieDetailsRouter.swift
//  MoviesBRQ
//
//  Created by Marcos Amorim Rossi de Carvalho on 01/07/21.
//

import Foundation
import UIKit

class MovieDetailsRouter: MovieDetailsPresenterToRouterProtocol{
    
    static func createModule() -> MovieDetailsView {
        
        let view = mainstoryboard.instantiateViewController(withIdentifier: "MovieDetailsView") as! MovieDetailsView
        
        let presenter: MovieDetailsViewToPresenterProtocol & MovieDetailsInteractorToPresenterProtocol = MovieDetailsPresenter()
        let interactor: MovieDetailsPresenterToInteractorProtocol = MovieDetailsInteractor()
        let router:MovieDetailsPresenterToRouterProtocol = MovieDetailsRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
        
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    
}
