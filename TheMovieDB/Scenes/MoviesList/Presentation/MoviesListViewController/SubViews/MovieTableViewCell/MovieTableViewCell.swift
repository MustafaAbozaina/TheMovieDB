//
//  MovieTableViewCell.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 17/04/2023.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    static let cellIdentifier = "MovieTableViewCell"
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
}

extension MovieTableViewCell: TitleSubtitleImageCell {
    var title: String? {
        get{return titleLabel.text}
        set {
            titleLabel.text = newValue
        }
    }
    
    var subtitle: String? {
        get{return subtitleLabel.text}
        set {
            subtitleLabel.text = newValue
        }
    }
    
    var imagePath: String? {
        get {return nil}
        set {
            posterImageView.setRemoteImage(newValue, placeHolder: UIImage(systemName: "square.fill"))
        }
    }
}
