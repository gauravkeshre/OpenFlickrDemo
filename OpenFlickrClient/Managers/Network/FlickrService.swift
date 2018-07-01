//
//  FlickrService.swift
//  OpenFlickrClient
//
//  Created by Gaurav Keshre on 01/07/18.
//  Copyright © 2018 Gaurav Keshre. All rights reserved.
//

import Foundation

class FlickrService: ServiceProtocol {
    static func fetchFlickrPhoto(tag: String, page: Int, onCompletion completion: @escaping (APIResult<FlickrPhotoResponse>) -> ()) -> CancelableTask? {
        
        let req = FlickrPhotoRequest(keyword: "dog", pageNo: page)
        let task = API.sendRequest(request: req) { (res) in
            completion(res)
        }
     return task
    }
}


