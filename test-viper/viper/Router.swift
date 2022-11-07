//
//  Router.swift
//  test-viper
//
//  Created by Jervy Umandap on 11/7/22.
//

import UIKit


// object
// entry point

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter: AnyObject {
//    var view: AnyView & UIViewController { get }
    var entry: EntryPoint? { get }
    static func start() -> AnyRouter
}

class UserRouter: AnyRouter {
    
    weak var entry: EntryPoint?
    
    static func start() -> AnyRouter {
        let router = UserRouter()
        
        // assign VIP
        let view: AnyView = UserViewController()
        let presenter: AnyPresenter = UserPresenter()
        let interactor: AnyInteractor = UserInteractor()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? EntryPoint
        
        return router
    }
    
    
}
