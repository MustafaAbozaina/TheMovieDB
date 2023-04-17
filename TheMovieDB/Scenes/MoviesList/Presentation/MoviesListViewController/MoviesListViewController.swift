//
//  MoviesDBViewController.swift
//  Temp1
//
//  Created by Mustafa Abozaina on 17/04/2023.
//

import UIKit

class MoviesListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var dataSource: [MovieEntity] = []
    var presenter: MoviesListOuput?
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        configureTableView()
        presenter?.viewLoaded()
    }
    
    func configureTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    convenience init(presenter: MoviesListOuput) {
        self.init()
        self.presenter = presenter
    }
}

extension MoviesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let element = dataSource[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = element.name
        return cell
    }
}

extension MoviesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

protocol MoviesListOuput {
    func viewLoaded()
}

extension MoviesListViewController: MoviesListPresenterDelegate {
    func moviesList(_ movies: [MovieEntity]) {
        self.dataSource = movies
        tableView.reloadData()
    }
    
    
}
