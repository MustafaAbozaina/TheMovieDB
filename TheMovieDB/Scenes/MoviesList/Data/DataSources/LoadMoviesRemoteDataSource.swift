//
//  LoadMoviesRemoteDataSource.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 13/05/2023.
//

import Foundation

class LoadMoviesRemoteDataSource: RemoteDataSource {
    typealias ResponseObject = MoviesDBRootDTO<[MovieDTO]>

    let urlPath: String 
    let parameters: [String : Any]?
    let headers: [String : String]?
    let httpMethod: HTTPMethod
    let network: Network
    
    init(network: Network,
         urlPath: String = "",
         parameters: [String: Any]? = [:],
         headers: [String: String] = [:],
         httpMethod: HTTPMethod = .get
    ) {
        self.network = network
        self.urlPath = urlPath
        self.parameters = parameters
        self.headers = headers
        self.httpMethod = httpMethod
    }
    
    func start(success: @escaping (MoviesDBRootDTO<[MovieDTO]>) -> (), failure: @escaping (Error?) -> ()) {
        network.load(urlPath: urlPath, httpMethod: httpMethod, parameters: parameters, headers: headers) { (moviesRoot: MoviesDBRootDTO<[MovieDTO]>?) in
            if let moviesRoot {
                success(moviesRoot)
            }
        } failure: { (networkFailure: NetworkFailure<NoType>) in
            failure(networkFailure.error)
        }
    }
}

struct NoType: Decodable {
    
}
