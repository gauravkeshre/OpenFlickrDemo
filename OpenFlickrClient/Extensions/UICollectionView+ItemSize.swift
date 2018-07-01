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
    
    func itemSize(numberOfItemsPerRow count: Int = Constants.CellsPerRow, paddingBetweenItems padding: Int = Constants.PaddingBetweenItems) -> CGSize {
        let totalPadding = CGFloat((count + 1) * padding)
        let width = floor((self.bounds.width - totalPadding) / CGFloat(count))
        return CGSize(width: width, height: width)
    }
}
