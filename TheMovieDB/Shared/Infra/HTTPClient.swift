//
//  HTTPClient.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 16/10/2023.
//

import Foundation

protocol HTTPClient {
    func request(urlPath: String, httpMethod: HTTPMethod, parameters: [String : Any]?,  headers: [String: String]?, result: @escaping (Result<(Data?, URLResponse?), Error>) -> ())
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

extension URLSession: HTTPClient {
    func request(urlPath: String, httpMethod: HTTPMethod, parameters: [String : Any]?,  headers: [String: String]? = nil, result: @escaping (Result<(Data?, URLResponse?), Error>) -> ()) {
        guard let urlRequest = buildRequest(urlPath: urlPath, httpMethod: httpMethod, parameters: parameters, headers: headers) else {return }
        self.dataTask(with: urlRequest) { data, response, error in
            result( Result {
                if let error = error {
                    throw error
                } else {
                    return (data, response)
                }
            })
        }.resume()
    }

    private func buildRequest(urlPath: String, httpMethod: HTTPMethod, parameters: [String: Any]?, headers: [String: String]? = nil) -> URLRequest? {
        guard let url = buildURL(urlPath: urlPath, parameters: parameters) else {return nil}

        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        if let unwrappedHeaders = headers {
            for (key, value) in unwrappedHeaders {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }

        return request
    }

    private func buildURL(urlPath: String, parameters: [String: Any]?) -> URL? {
        var urlComponents = URLComponents(string: urlPath)
        urlComponents?.queryItems = buildQueryParameters(parameters: parameters)

        return urlComponents?.url
    }

    private func buildQueryParameters(parameters: [String: Any]?) -> [URLQueryItem]? {
        guard let parameters = parameters else {
            return nil
        }
        var queryParamters: [URLQueryItem] = []
        for (key, value) in parameters {
            queryParamters.append(URLQueryItem(name: "\(key)", value: "\(value)") )
        }

        return queryParamters
    }
}
