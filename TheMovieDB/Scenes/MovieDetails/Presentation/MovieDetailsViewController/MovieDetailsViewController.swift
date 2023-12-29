//
//  MovieDetailsViewController.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 27/12/2023.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var viewModel: MovieDetailsViewModel?

    convenience init(viewModel: MovieDetailsViewModel?) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.viewDidLoaded()
        setup()
    }
    
    func setup() {
        setupViewModel()
    }
    
    func setupViewModel() {
        viewModel?.binding() { [weak self] movieEntity in
            DispatchQueue.main.async {
                if let coverUrl = movieEntity.imageUrl {
                    self?.posterImageView.setRemoteImage(coverUrl, placeHolder: UIImage(systemName: "square.fill"))
                }
                self?.titleLabel.text = movieEntity.title
                self?.overviewLabel.text = movieEntity.overview
            }
        }
    }
}
