//
//  JSONDecoding.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 17/10/2023.
//

import Foundation

extension JSONDecoder {
    static func decode<T: Decodable>(responseData: Data) -> T? {
        do {
            let responseModel = try JSONDecoder().decode(T.self, from: responseData)
            return responseModel
        } catch (let error) {
            debugPrint("Error decoding object \(T.self) with error \(error)")
            return nil
        }
    }
}
