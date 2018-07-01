//
//  UITextField+LeftView.swift
//  OpenFlickrClient
//
//  Created by Gaurav Keshre on 01/07/18.
//  Copyright © 2018 Gaurav Keshre. All rights reserved.
//

import Foundation
import UIKit

/** An extension that can be scaled to add UIButtons, UIImmages, UILabes, etc to the leftView property of a `UITextField`  */
extension UITextField {

    /** Adds an image in the `leftView` property of `UITextField`
     - Parameters:
        - image: The UIImage that need to be set in the leftView.
        - tint: Desired tint color if the UIImage is rendered with template mode
        - size: CGSize, Defaults to (44, 44)
     
     - Important:
        This method does nothing if the passed in `UIImage` is `nil`
     */
   
    func addLeftImage(_ image: UIImage?, tint: UIColor? = nil, size: CGSize = CGSize(width: 54, height: 54)) {
        guard let image = image else { return }
        
        
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: size))
        imageView.contentMode = .center
        imageView.image = image
        imageView.tintColor = tint
        
        self.leftView = imageView
        self.leftViewMode = .always
    }
}
