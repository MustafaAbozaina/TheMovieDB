//
//  Array+Indexing.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 31/12/2023.
//

import Foundation

extension Array {
    public subscript(safeIndex index: Int) -> Iterator.Element? {
        return index >= 0 && index < endIndex ? self[index] : nil
    }
}
