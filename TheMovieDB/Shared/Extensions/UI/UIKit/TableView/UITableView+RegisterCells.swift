//
//  UITableView+RegisterCells.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 17/04/2023.
//

import UIKit

extension UITableView {
    @discardableResult
    func registerFromNib(cell: UITableViewCell.Type) -> Bool {
        guard let nib = UINib.nibFor(cell) else {return false}
        self.register(nib, forCellReuseIdentifier: String(describing: cell))
        
        return true
    }
}
