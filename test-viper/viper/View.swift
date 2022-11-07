//
//  View.swift
//  test-viper
//
//  Created by Jervy Umandap on 11/7/22.
//

import UIKit

// ViewController
// protocol
// reference presenter


protocol AnyView: AnyObject {
    var presenter: AnyPresenter? { get set }
    
    func update(with users: [User])
    func update(with error: String)
}

class UserViewController: UIViewController, AnyView, UITableViewDelegate, UITableViewDataSource {
    
    var presenter: AnyPresenter?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.isHidden = true
        return tableView
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.isHidden = true
        label.textColor = .label
        return label
    }()
    
    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        
        view.addSubview(errorLabel)
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        errorLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        errorLabel.center = view.center
        tableView.frame = view.bounds
    }
    
    func update(with users: [User]) {
        print("got users!")
        DispatchQueue.main.async {
            self.users = users
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    
    func update(with error: String) {
        print("update Error: \(error)")
        DispatchQueue.main.async {
            self.users = []
            self.errorLabel.text = error
            self.tableView.isHidden = true
            self.errorLabel.isHidden = false
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
