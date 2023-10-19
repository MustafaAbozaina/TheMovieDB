//
//  File.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 19/10/2023.
//

import UIKit

protocol TitleSubtitleImageCell where Self: UITableViewCell {
    var title: String? {get set}
    var subtitle: String? {get set}
    var imagePath: String? {get set}
}
