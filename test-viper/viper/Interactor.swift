//
//  Interactor.swift
//  test-viper
//
//  Created by Jervy Umandap on 11/7/22.
//

import Foundation

// object
// protocol
// reference to presenter
// https://jsonplaceholder.typicode.com/users


protocol AnyInteractor: AnyObject {
    var presenter: AnyPresenter? { get set }
    
    func getUsers()
}

class UserInteractor: AnyInteractor {
    weak var presenter: AnyPresenter?
    
    func getUsers() {
        print("start fetching")
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidFetchUsers(with: .failure(FetchError.failed))
                return
            }
            
            do {
                let entities = try JSONDecoder().decode([User].self, from: data)
                
                self?.presenter?.interactorDidFetchUsers(with: .success(entities))
                
            } catch {
                self?.presenter?.interactorDidFetchUsers(with: .failure(error))
            }
            
        }
        task.resume()
    }
    
    
}

