//
//  ImageItem.swift
//  OpenFlickrClient
//
//  Created by Gaurav Keshre on 01/07/18.
//  Copyright © 2018 Gaurav Keshre. All rights reserved.
//

import Foundation


/** Models one flickr photo object  */
struct FlickrPhoto {
    let id: String
    let title: String?
    
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    
    /* Other properties keeping only for complete representation. */
    let isPublic: Bool
    let isFamily: Bool
    let isFriend: Bool
    
    /** Computed convenience property that returns the final url where the photo can be downloaded
     - Important:
        expression is as : "http://farm{farm}.static.flickr.com/{server}/{id}_{secret}.jpg"
     */
    var imageURL: String {
        return "http://farm\(farm).static.flickr.com/\(server)/\(id)_\(secret).jpg"
    }
    
    
    /** Initializer that essentially serializes the dictionary to concrete object.
     - Parameter:
     - JSONDictionary: [String: Any]
     - Important:
        This can be done evem more cleanly with `Codable` protocol and can be considered as future enhancements*/
    init?(dictionary: JSONDictionary) {
        guard
            let _id = dictionary["id"] as? String,
            let _owner = dictionary["owner"] as? String,
            let _secret = dictionary["secret"] as? String,
            let _server = dictionary["server"] as? String,
            let _farm = dictionary["farm"] as? Int else {
                return nil
        }
        
        self.id = _id
        self.owner = _owner
        self.secret = _secret
        self.server = _server
        self.farm = _farm
        
        self.title = dictionary["title"] as? String
        
        self.isPublic = (dictionary["ispublic"] as? Bool) ?? false
        self.isFamily = (dictionary["isfamily"] as? Bool) ?? false
        self.isFriend = (dictionary["isfriend"] as? Bool) ?? false

    }
}


struct FlickrPhotosResult {
    let pageNumber: Int
    let numberOfPhotosPerPage: Int

    let totalPages: Double
    let totalPhotos: Double
   
    let photos: [FlickrPhoto]
    
    init?(dictionary: JSONDictionary) {
        guard let body = dictionary["photos"] as? JSONDictionary else{
            return nil
        }
        
        self.pageNumber = (body["page"] as? Int) ?? -1

        self.numberOfPhotosPerPage = (body["perpage"] as? Int) ?? -1
        
        self.totalPages = (body["pages"] as? Double) ?? -1
        
        
        if let strVal = body["total"] as? String, let doubleVal = Double(strVal){
            self.totalPhotos = doubleVal
        }else {
            self.totalPhotos = -1
        }

        if let photosArr = body["photo"] as? [JSONDictionary] {
            photos = photosArr.compactMap{FlickrPhoto(dictionary: $0)}
        }else {
            photos = []
        }
    }
}
