//
//  ToEntity.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 14/05/2023.
//

import Foundation

protocol ToEntity {
    associatedtype Entity
    func toEntity() -> Entity
}
