//
//  UINib+Loading.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 17/04/2023.
//

import UIKit

extension UINib {
    static func nibFor(_ object: AnyObject) -> UINib? {
        let nibBundle = Bundle.main
        let objectIdentifier = String(describing: object)
        let components = objectIdentifier.components(separatedBy: ".")
        let cellIdentifier = components.last ?? ""
        if nibBundle.path(forResource: cellIdentifier, ofType: "nib") != nil {
            return UINib(nibName: cellIdentifier, bundle: nil)
        } else {
            return nil
        }
    }
}
