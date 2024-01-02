//
//  iOSViewControllerFactory.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 18/04/2023.
//

import UIKit

class ModuleFactory {
    func createApiHeaders() -> [String: String] {
        let apiKey = ProcessInfo.processInfo.environment["API_KEY"] ?? ""
        return ["Authorization": "Bearer \(apiKey)",
                "accept": "application/json"]
    }
}
