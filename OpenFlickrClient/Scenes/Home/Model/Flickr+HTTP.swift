//
//  Flickr+HTTP.swift
//  OpenFlickrClient
//
//  Created by Gaurav Keshre on 01/07/18.
//  Copyright © 2018 Gaurav Keshre. All rights reserved.
//

import Foundation


private enum FlickrConstants{
    static  let FlickrAPIURL = "https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&safe_search=1"
    static  let FlickrAPIKey = "3e7cc266ae2b0e0d78e279ce8e361736"
}

struct FlickrPhotoRequest: Request {

    var url: String = FlickrConstants.FlickrAPIURL
    
    var params: [String : Any]? = ["api_key": FlickrConstants.FlickrAPIKey]
    
    init(keyword: String?, pageNo: Int) {
        self.params? ["page"] = pageNo
        if let keyword = keyword {
            self.params?["text"] = keyword
        }
    }
}

/** Response */
struct FlickrPhotoResponse: Response {
    typealias Body = FlickrPhotosResult
    
    var message: String?
    
    var body: FlickrPhotosResult?
    
    static func parse(dictionary: JSONDictionary) -> FlickrPhotoResponse {
        let body: FlickrPhotosResult? = FlickrPhotosResult(dictionary: dictionary)
        
        return FlickrPhotoResponse(message: dictionary["message"] as? String,
                                   body: body)
    }
}
