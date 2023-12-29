//
//  NetworkManager.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 16/10/2023.
//

import Foundation

protocol Network {
    func load<Success: Decodable, Failure: Decodable>(urlPath: String, httpMethod: HTTPMethod, parameters: [String: Any]?, headers: [String: String]?, success: @escaping (Success) -> (), failure: @escaping (NetworkFailure<Failure>)-> ())
}

class NetworkManager: Network {
    
    let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func load<SuccessModel: Decodable, FailureModel: Decodable>(urlPath: String,
                                                                httpMethod: HTTPMethod,
                                                                parameters: [String : Any]?,
                                                                headers: [String : String]?,
                                                                success: @escaping (SuccessModel) -> (),
                                                                failure: @escaping (NetworkFailure<FailureModel>) -> ()) {
        
        self.httpClient.request(urlPath: urlPath, httpMethod: httpMethod, parameters: parameters, headers: headers) { result in
            switch result {
            case .success(let successModel):
                self.handleResult(data: successModel.0, response: successModel.1 as? HTTPURLResponse, success: success, failure: failure)
            case .failure(let error):
                failure(NetworkFailure(error: .responseFailure(error)))
            }
        }
    }
    
    private func handleResult<T: Decodable, F: Decodable>(data: Data?,
                                                          response: HTTPURLResponse?,
                                                          success: @escaping (T)-> Void,
                                                          failure: (NetworkFailure<F>)-> Void) {
        var statusCodeFailed = false
        
        debugPrint("api call response for \(String(describing: response))")
        if let data = data, let responseBody = String(data: data, encoding: .utf8) {
            debugPrint("Response Body: \(responseBody)")
        }
        guard let data = data, let response = response else {
            failure(.init(failureModel: nil, error: .responseFailure(nil), stausCode: response?.statusCode ))
            return
        }
            if response.statusCode > 299 || response.statusCode < 200  {
                statusCodeFailed = true
        }
        if (statusCodeFailed) {
            failure(self.buildFailureModel(data: data, response: response))
        }
        else {
            if let successModel: T = self.decodeDataToModel(data: data) {
                success(successModel)
            } else {
                failure(.init(failureModel: nil, error: .failedToMapDataToModel, stausCode: response.statusCode))
            }
        }
    }
    
    private func buildFailureModel<F: Decodable>(data: Data, response: URLResponse) -> NetworkFailure<F> {
        let failureResponse: F? = self.decodeDataToModel(data: data)
        var errorType: NetworkError = .generalError
                if failureResponse == nil {
                    errorType = .failedToMapDataToModel
                }
        let statusCode = (response as? HTTPURLResponse)?.statusCode
             return .init(failureModel: failureResponse, error: errorType, stausCode: statusCode)
    }
        
    private func decodeDataToModel<T: Decodable>(data: Data) -> T? {
        let decodedValue: T? = JSONDecoder.decode(responseData: data)
        return decodedValue
    }
}

enum NetworkError: Error {
    case generalError
    case responseFailure(Error?)
    case failedToMapDataToModel
}

struct NetworkFailure<F: Decodable> {
    var failureModel: F?
    var error: NetworkError?
    var stausCode: Int?
}
