//
//  Presenter.swift
//  test-viper
//
//  Created by Jervy Umandap on 11/7/22.
//

import Foundation


// object
// protocol
// reference to interactor, router, view

enum FetchError: Error {
    case failed
}

protocol AnyPresenter: AnyObject {
    var router: AnyRouter? { get set }
    var interactor: AnyInteractor? { get set }
    var view: AnyView? { get set }
    
    func interactorDidFetchUsers(with result: Result<[User], Error>)
}

class UserPresenter: AnyPresenter {
    weak var router: AnyRouter?
    
    var interactor: AnyInteractor? {
        didSet {
            interactor?.getUsers()
        }
    }
    
    var view: AnyView?
    
    init() {
        interactor?.getUsers()
    }
    
    func interactorDidFetchUsers(with result: Result<[User], Error>) {
        switch result {
        case .success(let users):
            view?.update(with: users)
        case .failure:
            view?.update(with: "Something went wrong")
        }
    }
    
    
}
