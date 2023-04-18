//
//  UseCase.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 18/04/2023.
//

import Foundation

protocol UseCase {
    associatedtype Output
    associatedtype Input
    func start(output: Output)
}
