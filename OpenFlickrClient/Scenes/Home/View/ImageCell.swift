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
    
    
    private var isLoading: Bool = false{
        didSet {
            DispatchQueue.main.async {
                if self.isLoading {
                    self.imageView.image = #imageLiteral(resourceName: "bg_loading")
                    self.activityIndicator.startAnimating()
                }else {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                }
            }
        }
    }
    
    //MARK:- LifeCycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 4
        self.layer.masksToBounds = true
    }
    
    //MARK:- Public Methods
    func configure(_ data: FlickrPhoto) {
        imageView.loadImage(fromURL: data.imageURL, placeholder: #imageLiteral(resourceName: "bg_placeholder")) { (status, _) in
            if case .downloading = status {
                self.isLoading = true
            }else {
                self.isLoading = false
            }
        }
    }
}
