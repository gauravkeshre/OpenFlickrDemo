//
//  ImageCacheManager.swift
//  OpenFlickrClient
//
//  Created by Gaurav Keshre on 01/07/18.
//  Copyright © 2018 Gaurav Keshre. All rights reserved.
//

import Foundation
import UIKit

/** A protocol that dictates the way an ImageCache should function. */
protocol ImageCacheProtocol {
    var maxCachedImages: Int {get}
    
    func addImage(_ image: UIImage, forKey key: String)
    func fetchImage(forKey key: String) -> UIImage?
    func removeImage(forKey keys: String...)
    func clearCache()
}

/** A singleton class that abstract the details of how the images are being cached.
 For starters, we will store the images in `Foundation.Cache` but will upgrade to to file system in phase 2.
 */
final class ImageCacheManager: ImageCacheProtocol {
   
    /** Instance */
    static let shared: ImageCacheManager = {
        let limit = Int.max
        let ins = ImageCacheManager(maxCachedImages: limit)
        ins.cache.countLimit = limit
        ins.cache.name = "OpenFlickrImageCache"
        
        return ins
    }()
    
    init(maxCachedImages: Int) {
        self.maxCachedImages = maxCachedImages
    }
    
    /** Storage */
    private let cache: NSCache = NSCache<NSString, UIImage>()
    
    
    /** ImageCacheProtocol Conformance */
    //MARK:- ImageCacheImageCacheProtocol Methods

    var maxCachedImages: Int
    
    func addImage(_ image: UIImage, forKey key: String) {
        let key = key as NSString
        cache.setObject(image, forKey: key)
    }
    
    func fetchImage(forKey key: String) -> UIImage? {
        let key = key as NSString
        return cache.object(forKey: key)
    }
    
    func removeImage(forKey keys: String...) {
        for ke in keys {
        cache.removeObject(forKey: ke as NSString)
        }
    }
    
    func clearCache() {
        cache.removeAllObjects()
    }
    
    
    func removeImage(forURL key: String) {
        cache.removeObject(forKey: key as NSString)
    }
    
}
