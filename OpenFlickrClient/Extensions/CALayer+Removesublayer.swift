//
//  CALayer+Removesublayer.swift
//  OpenFlickrClient
//
//  Created by Gaurav Keshre on 05/07/18.
//  Copyright © 2018 Gaurav Keshre. All rights reserved.
//

import Foundation
import UIKit

extension CALayer {
    
    /**
     A handly helper method to find a  `sublayers` by name from a `CALayer` object
     - important: Loop through all sublayers and check if any of has same name as passed in argument.
     - Parameter: names - `named` of String type
     */
    func sublayer(named nameToFind: String) -> CALayer? {
        let subLayersFound = self.sublayers?.filter{$0.name == nameToFind}
        if let sl = subLayersFound, let ll = sl.first {
            return ll
        }
        return nil
    }
    
    /**
     A handly helper method to remove `sublayers` by name from a `CALayer` object
     - important: Loop through all sublayers and check if any of has same name as one of the `names`.
     - Parameter: names - `varags` of String type
     */
    func removeSublayers(names: String...) {
        guard let mLayers = self.sublayers?.filter({ (sLayer) -> Bool in
            var flag = false
            for name in names{
                flag = flag || (sLayer.name == name)
                ///break the loop as we have found that the flag is true and we dont need to check further.
                if flag{ break }
            }
            return flag
        }), mLayers.count > 0 else{
            print("no layers found")
            return
        }
        /** Loop through all filte and check if any of has same name as one of the `names`. */
        mLayers.forEach{$0.removeFromSuperlayer()}
    }
}
