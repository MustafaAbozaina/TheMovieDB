//
//  RemoteDataSource.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 12/05/2023.
//

import Foundation

protocol RemoteDataSource:  DataSource {
    associatedtype ResponseObject
    func start(success: @escaping (_ a: ResponseObject) -> (), failure: @escaping (_ error: Error?) -> ())
}

