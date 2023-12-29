//
//  UIImageView+RemoteImages.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 28/12/2023.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setRemoteImage(_ urlPath: String?, placeHolder: UIImage?) {
        kf.setImage(with: URL(string: urlPath ?? ""), placeholder: placeHolder)
    }
}
