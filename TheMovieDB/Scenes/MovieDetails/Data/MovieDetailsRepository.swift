//
//  MovieDetailsRepository.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 26/12/2023.
//

import Foundation

class MovieDetailsRepository: Repository {
    let dataSources: [DataSource]
    
    init(dataSources: [DataSource]) {
        self.dataSources = dataSources
    }
}

extension MovieDetailsRepository: LoadMovieDetailsRepository {
    func loadMovieDetails(success: @escaping (MovieDetailsEntity) -> (), failure: @escaping (Error) -> ()) {
        loadMovieDetailsRemoteDataSource?.start(success: { response in
            if let movieDetails = response as? MovieDetailsDTO {
                success(movieDetails.toEntity())
            }
        }, failure: { (error: Error?) in
            
        })
    }
   
    var loadMovieDetailsRemoteDataSource: (any RemoteDataSource)? {
        return dataSources.first(where: {$0 is (any RemoteDataSource)}) as?  (any RemoteDataSource)
    }
}
