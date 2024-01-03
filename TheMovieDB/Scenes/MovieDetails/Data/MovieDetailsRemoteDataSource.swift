//
//  MovieDetailsRemoteDataSource.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 26/12/2023.
//

import Foundation

class LoadMovieDetailsRemoteDataSource: RemoteDataSource {
    typealias ResponseObject = MovieDetailsDTO?
    
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
    
    func start(success: @escaping (ResponseObject) -> (), failure: @escaping (Error?) -> ()) {
        network.load(urlPath: urlPath, httpMethod: httpMethod, parameters: parameters, headers: headers) { (movieDetails: MovieDetailsDTO?) in
            if let movieDetails {
                success(movieDetails)
            }
        } failure: { (networkFailure: NetworkFailure<PlaceholderModel>) in
            failure(networkFailure.error)
        }
    }
}
