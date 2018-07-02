//
//  UICollectionView+ItemSize.swift
//  OpenFlickrClient
//
//  Created by Gaurav Keshre on 01/07/18.
//  Copyright © 2018 Gaurav Keshre. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {

/** Returns the estimated cell size (*square*) requrired to fit `numberOfItemsPerRow` in one row.
 - Parameters:
    - numberOfItemsPerRow: Int, number of cells we need to fit in one row. While at the same time respecting `minimumInterItemSpacing`
 - Important:
     - This method assumes that the collectionview layout is `UICollectionViewFlowLayout`
 */
func itemSize(numberOfItemsPerRow count: Int = Constants.CellsPerRow) -> CGSize {
    let itemSpacing: CGFloat
    
    if let pad = (self.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing {
        itemSpacing = pad
    }else {
        itemSpacing = 0
    }
    
    let totalPadding = CGFloat(count + 1) * itemSpacing
    let width = floor((self.bounds.width - totalPadding) / CGFloat(count))
    return CGSize(width: width, height: width)
}
}
