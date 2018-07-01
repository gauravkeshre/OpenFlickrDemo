//
//  Service.swift
//  OpenFlickrClient
//
//  Created by Gaurav Keshre on 01/07/18.
//  Copyright © 2018 Gaurav Keshre. All rights reserved.
//

import Foundation

protocol ServiceProtocol {
    
    @discardableResult
    static func fetchFlickrPhoto(tag: String, page: Int, onCompletion completion: @escaping (APIResult<FlickrPhotoResponse>) -> ()) -> CancelableTask?
    
}
