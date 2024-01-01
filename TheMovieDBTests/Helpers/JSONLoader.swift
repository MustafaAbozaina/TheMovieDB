//
//  JSONLoader.swift
//  TheMovieDBTests
//
//  Created by Mustafa Abozaina on 01/01/2024.
//

import Foundation

class JSONLoader {
    
    static func loadFromTestingBundle(bundleObject:AnyObject, fileName: String, fileExtension: String) -> Data {
        let data: Data
        let testBundle = Bundle(for: type(of: bundleObject))
        let filePath = testBundle.path(forResource: fileName, ofType: fileExtension)
        do {
            data = try Data(contentsOf: URL(fileURLWithPath: filePath!)) //
        } catch {
            fatalError("Couldn't load \(String(describing: filePath)) from main bundle:\n\(error)")
        }
        return data
    }
 
}
