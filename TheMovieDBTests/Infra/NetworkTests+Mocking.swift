//
//  NetworkTests+Helpers.swift
//  TheMovieDBTests
//
//  Created by Mustafa Abozaina on 01/01/2024.
//

import Foundation


struct RootModel<D: Codable>: Codable {
    let data: D
}


class MockedDTO: Decodable {}

struct MockedNetworkFailureModel: Decodable {}


func getValidJsonData() -> Data? {
    let dummyJson = ["key": "value"]
    let jsonEncoder = JSONEncoder()
    if let data = try? jsonEncoder.encode(dummyJson) {
        return data
    } else {
        return nil
    }
}

func getInvalidData() -> Data {
    return Data()
}

struct GeneralTestingJsonRoot: Codable  {
    var root: [GeneralTestingJson]
}

struct GeneralTestingJson: Codable {
    var id: Int?
    var title: String?
    var subTitle: String?
    var url: String?
}


