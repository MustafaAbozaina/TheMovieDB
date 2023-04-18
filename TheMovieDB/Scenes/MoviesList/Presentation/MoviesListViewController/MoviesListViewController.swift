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
    var presenter: MoviesListEventOuput?
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        configureTableView()
        presenter?.viewLoaded()
    }
    
    func configureTableView() {
        tableView.registerFromNib(cell: MovieTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    convenience init(presenter: MoviesListEventOuput) {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieTableViewCell.self), for: indexPath) as? MovieTableViewCell
        cell?.titleLabel?.text = element.name
        return cell ?? UITableViewCell()
    }
}

extension MoviesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

protocol MoviesListEventOuput {
    func viewLoaded()
    func movieSelected(row: Int)
}

extension MoviesListViewController: MoviesListPresenterDelegate {
    func moviesList(_ movies: [MovieEntity]) {
        self.dataSource = movies
        tableView.reloadData()
    }
}
