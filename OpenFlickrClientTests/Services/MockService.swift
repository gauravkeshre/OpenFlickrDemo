//
//  MockService.swift
//  OpenFlickrClientTests
//
//  Created by Gaurav Keshre on 04/07/18.
//  Copyright © 2018 Gaurav Keshre. All rights reserved.
//

import UIKit
@testable import OpenFlickrClient

/** Mocks an Service that always results into a success.
It uses `happy_dataset` to render data */
class MockServiceSuccess: ServiceProtocol {
    @discardableResult
    static func fetchFlickrPhoto(tag: String, page: Int, onCompletion completion: @escaping (APIResult<FlickrPhotoResponse>) -> ()) -> CancelableTask? {
        let mockDictionary = MockData.happy.jsonDictionary()
        let response = FlickrPhotoResponse.parse(dictionary: mockDictionary)
        let result = APIResult.success(response)
        completion(result)
        return nil
    }
}

/** Mocks an Service that always results into an error */
class MockServiceFailure: ServiceProtocol {
    static let errorMessage = "The server could not be reached at this moment"
    @discardableResult
    static func fetchFlickrPhoto(tag: String, page: Int, onCompletion completion: @escaping (APIResult<FlickrPhotoResponse>) -> ()) -> CancelableTask? {
        let result = APIResult<FlickrPhotoResponse>.failure(ResponseError.custom(errorMessage))
        completion(result)
        return nil
    }
}
