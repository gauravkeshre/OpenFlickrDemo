//
//  ImageCell.swift
//  OpenFlickrClient
//
//  Created by Gaurav Keshre on 01/07/18.
//  Copyright © 2018 Gaurav Keshre. All rights reserved.
//

import UIKit

final class ImageCell: UICollectionViewCell {
    @IBOutlet private weak var imageView : UIImageView!
    @IBOutlet private weak var activityIndicator : UIActivityIndicatorView!
    func configure(_ data: FlickrPhoto) {
        
    }
}
