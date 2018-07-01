//
//  UIColor+App.swift
//  OpenFlickrClient
//
//  Created by Gaurav Keshre on 01/07/18.
//  Copyright © 2018 Gaurav Keshre. All rights reserved.
//

import Foundation
import  UIKit

/** An extension on UIColor that provides convenience for app color pallete
 */

extension UIColor {
    
    static var appPrimaryColor: UIColor {
        return #colorLiteral(red: 0.1764705882, green: 0.3960784314, blue: 0.7294117647, alpha: 1)
    }
    
    static var appAlternatePrimaryColor: UIColor {
        return #colorLiteral(red: 0.9294117647, green: 0.3215686275, blue: 0.5058823529, alpha: 1)
    }
}
