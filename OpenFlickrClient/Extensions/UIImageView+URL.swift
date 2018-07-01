//
//  UIImage+URL.swift
//  OpenFlickrClient
//
//  Created by Gaurav Keshre on 01/07/18.
//  Copyright © 2018 Gaurav Keshre. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    typealias ImageLoadingCallback = (ImageLoadingStatus, UIImage?) -> ()
    enum ImageLoadingStatus {
        case foundInCache, downloading, success, failure
    }
    
    /** Loads Image from URL and sets the downloaded Image to `image` property.
     This method checks the cache and if the cache misses, it downloads the image from server.
     - Parameters:
     - imageURL: An optional String.
     - placeholder: An optinal image that is set if the image is
     - callback: Closure that takes current image loading status and downloaded image optionally.
     
     - Important:
     The image in the closure is only for reference and this method already sets the `image` of `self`
     */
    func loadImage(fromURL imageurl: String?,
                   placeholder: UIImage? = nil,
                   onCompletion callback: @escaping ImageLoadingCallback) {
        guard let strURL = imageurl else {
            self.image = placeholder
            callback(.failure, nil);
            return
        }
        
        if let image = ImageCacheManager.shared.fetchImage(forKey: strURL) {
            DispatchQueue.main.async() {
                self.image = image
            }
            callback(.foundInCache, image)
            return
        }
        
        guard let url = URL(string: strURL) else {
            self.image = placeholder
            callback(.failure, nil);
            return
        }
        
        callback(.downloading, nil)
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil, let imgData = data, let image = UIImage(data: imgData) else {
                self.image = placeholder
                callback(.failure, nil);
                return
            }
            
            ///save
            ImageCacheManager.shared.addImage(image, forKey: strURL)
            
            DispatchQueue.main.async() {
                self.image = image
            }
            callback(.success, image)
        }
        dataTask.resume()
    }
}
