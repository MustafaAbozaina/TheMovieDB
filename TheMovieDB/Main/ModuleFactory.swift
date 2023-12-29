//
//  iOSViewControllerFactory.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 18/04/2023.
//

import UIKit

class ModuleFactory {
    func createApiHeaders(apiKey: String = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzOTkzZGFkMzg2ZWJiMjc1ZmZmOWNkMzY4NzQwNDU4YiIsInN1YiI6IjY1MzAwNDZkZWRlYjQzMDExYjQ0YTg5MiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ZjMq39ACJmuEWlj08Kaq4iJNBkzBk1JETb19lte_ahY") -> [String: String] {
        return ["Authorization": "Bearer \(apiKey)",
                "accept": "application/json"]
    }
}



