//
//  MovieTableViewCell.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 17/04/2023.
//

import UIKit
import Kingfisher


class MovieTableViewCell: UITableViewCell {
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
            let imageUrl = URL(string: newValue ?? "")
            posterImageView.kf.setImage(with: imageUrl, placeholder: UIImage(systemName: "square.fill"))
        }
    }
}
