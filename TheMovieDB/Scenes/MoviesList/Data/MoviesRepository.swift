//
//  MoviesRepository.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 12/05/2023.
//

import Foundation

class MoviesRepository: Repository {
    let dataSources: [DataSource]
    
    init(dataSources: [any DataSource]) {
        self.dataSources = dataSources
    }
    
}

extension MoviesRepository: LoadMoviesRepository {
    typealias ResponseObject = [MovieEntity]
    func loadMovies(success: @escaping (ResponseObject) -> (), failure: @escaping (Error) -> ()) {
        loadMoviesRemoteDataSource?.start(success: { response in
            if let movies = response as? MoviesDBRootDTO<[MovieDTO]> {
                success(movies.results?.map({$0.toEntity()}) ?? [])
            }
        }, failure: { (error: Error?) in
            
        })
    }
    var loadMoviesRemoteDataSource: (any RemoteDataSource)? {
        return dataSources.first(where: {$0 is (any RemoteDataSource)}) as?  (any RemoteDataSource)
    }    
}
