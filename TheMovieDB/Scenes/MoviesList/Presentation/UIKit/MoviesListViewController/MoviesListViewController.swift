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
    var cellsIdentifiers: [String] = []
    var presenter: MoviesListEventOuput?
    
    convenience init(presenter: MoviesListEventOuput, cellsIdentifiers: [String]) {
        self.init()
        self.presenter = presenter
        self.cellsIdentifiers = cellsIdentifiers
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        title = "Popular Movies"
        configureTableView()
        presenter?.viewLoaded()
    }
    
    func configureTableView() {
        for cellIdentifier in cellsIdentifiers {
            let nib = UINib(nibName: cellIdentifier, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        }
        tableView.dataSource = self
        tableView.delegate = self
    }
}

//MARK: TableView DataSource
extension MoviesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let element = dataSource[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: cellsIdentifiers[indexPath.section]), for: indexPath) as? TitleSubtitleImageCell
        cell?.title = element.name
        cell?.subtitle = element.overview
        cell?.imagePath = element.imageUrl
        return cell ?? UITableViewCell()
    }
}

//MARK: TableView Delegates
extension MoviesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.movieSelected(row: indexPath.row)
    }
}

protocol MoviesListEventOuput {
    func viewLoaded()
    func movieSelected(row: Int)
}

extension MoviesListViewController: MoviesListPresenterDelegate {
    func moviesList(_ movies: [MovieEntity]) {
        DispatchQueue.main.async {
            self.dataSource = movies
            self.tableView.reloadData()
        }
    }
}
