//
//  MockData.swift
//  OpenFlickrClientTests
//
//  Created by Gaurav Keshre on 04/07/18.
//  Copyright © 2018 Gaurav Keshre. All rights reserved.
//

import Foundation
@testable import OpenFlickrClient

typealias JSONDictionary = [String: Any?]

/** An enum to make it convenient to mock the data and organize it */
enum MockData: String {
    case happy = "happy"
    case resultWithoutPhotos = "result_without_photos"
    case empty = "empty"
    case missingValues = "result_with_missing_values"
    
    
    func jsonDictionary() -> JSONDictionary {
        guard
            let bundle = Bundle(identifier: "gk.demo.OpenFlickrClientTests"),
            let url = bundle.url(forResource: "\(self.rawValue)_dataset", withExtension: "json")
            else { return [:]}
        
        guard let jsonData = try? Data(contentsOf: url, options: .mappedIfSafe) else { return [:]}
        
        guard let jsonResult = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) else { return [:] }
        
        return jsonResult as! JSONDictionary
    }
    
    
    static func imageResultModel(for mock: MockData) -> FlickrPhotosResult? {
        let mockData = mock.jsonDictionary()
        return FlickrPhotosResult.init(dictionary: mockData)
    }

}
