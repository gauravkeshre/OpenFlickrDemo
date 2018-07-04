//
//  MockService.swift
//  OpenFlickrClientTests
//
//  Created by Gaurav Keshre on 04/07/18.
//  Copyright © 2018 Gaurav Keshre. All rights reserved.
//

import UIKit
@testable import OpenFlickrClient

class MockService: ServiceProtocol {
    
    @discardableResult
    static func fetchFlickrPhoto(tag: String, page: Int, onCompletion completion: @escaping (APIResult<FlickrPhotoResponse>) -> ()) -> CancelableTask? {
        
let response = FlickrPhotoResponse.parse(dictionary: <#T##JSONDictionary#>)
        
    }

}
