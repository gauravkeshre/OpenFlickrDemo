//
//  UIView+Decoration.swift
//  OpenFlickrClient
//
//  Created by Gaurav Keshre on 01/07/18.
//  Copyright © 2018 Gaurav Keshre. All rights reserved.
//

import Foundation
import UIKit

struct DecorationConstants{
    static let ShadowRadius: CGFloat = 4.0
    static let ShadowOpacity: Float = 0.2
    static let ShadowColor: UIColor = .lightGray
    static let ShadowLayerName = "shadow_layer_zc"
    static let ShapeLayerName = "shape_layer_zc"
}


extension UIView {
    
   
    
    func decorateWithCornerRadius(cornerRadius: CGFloat = DecorationConstants.ShadowRadius,
                                  borderColor: UIColor = DecorationConstants.ShadowColor,
                                  borderWidth: CGFloat = 0,
                                  enableShadow: Bool = true ){
        
        self.decorate(layer: layer,
                      cornerRadius: cornerRadius,
                      roundedCorners: .allCorners,
                      borderColor: borderColor,
                      borderWidth: borderWidth,
                      enableShadow: enableShadow)
    }
    
    
    func decorate(layer: CALayer,
                  cornerRadius: CGFloat = DecorationConstants.ShadowRadius,
                  roundedCorners: UIRectCorner = .allCorners,
                  borderColor: UIColor = .clear,
                  borderWidth: CGFloat = 0,
                  enableShadow: Bool = true ){
        
        if #available(iOS 11.0, *) {
            ///CORNER
            self.layer.cornerRadius = cornerRadius
            self.layer.maskedCorners = UIRectCorner.allCorners.toCornerMask
            
            ///SHADOW
            if enableShadow {
                let rectanglePath =  UIBezierPath(roundedRect: self.bounds,
                                                  byRoundingCorners: roundedCorners,
                                                  cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
                layer.shadowColor    = UIColor.black.cgColor
                layer.shadowOffset   = CGSize(width: 0, height: 1)
                layer.shadowOpacity  = DecorationConstants.ShadowOpacity
                layer.shadowRadius  = DecorationConstants.ShadowRadius
                layer.shadowPath    = rectanglePath.cgPath
            }else {
                layer.shadowColor    = UIColor.clear.cgColor
                layer.shadowOffset   = CGSize(width: 0, height: 0)
                layer.shadowOpacity  = 0
                layer.shadowRadius  = 0
            }
        } else {
            let cornerRadiusLayer: CAShapeLayer
            if let lyr = layer.sublayer(named: DecorationConstants.ShapeLayerName) as? CAShapeLayer {
                cornerRadiusLayer = lyr
            }else {
                cornerRadiusLayer = CAShapeLayer()
                layer.removeSublayers(names: DecorationConstants.ShapeLayerName)
            }

            let rectanglePath =  UIBezierPath(roundedRect: self.bounds,
                                              byRoundingCorners: roundedCorners,
                                              cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
            layer.masksToBounds = false
            
            
            cornerRadiusLayer.name = DecorationConstants.ShapeLayerName
            cornerRadiusLayer.fillColor = self.backgroundColor?.cgColor
            cornerRadiusLayer.lineWidth = borderWidth
            cornerRadiusLayer.path = rectanglePath.cgPath
            cornerRadiusLayer.strokeColor = borderColor.cgColor
            self.layer.insertSublayer(cornerRadiusLayer, at: 0)
            
//            self.backgroundColor = .white
            
            layer.removeSublayers(names: DecorationConstants.ShadowLayerName)
            if enableShadow {
                let shadowLayer: CAShapeLayer  = CAShapeLayer()
                shadowLayer.name = DecorationConstants.ShadowLayerName
                shadowLayer.fillColor = UIColor.clear.cgColor
                shadowLayer.path = rectanglePath.cgPath
                shadowLayer.shadowOffset = CGSize(width: 0, height: 1)
                shadowLayer.shadowPath = rectanglePath.cgPath
                shadowLayer.shadowColor = UIColor.black.cgColor
                shadowLayer.shadowRadius = DecorationConstants.ShadowRadius
                shadowLayer.shadowOpacity = DecorationConstants.ShadowOpacity
                self.layer.insertSublayer(shadowLayer, below: cornerRadiusLayer)
            }
        }
    }
    
    
}




private extension UIRectCorner {
    var toCornerMask: CACornerMask {
        
        guard !self.contains(.allCorners) else {
            return  [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        }
        var cornerMask: CACornerMask = []
        
        if self.contains(.topLeft) {
            cornerMask.insert(.layerMinXMinYCorner)
        }
        if self.contains(.topRight) {
            cornerMask.insert(.layerMaxXMinYCorner)
        }
        if self.contains(.bottomLeft) {
            cornerMask.insert(.layerMinXMaxYCorner)
        }
        if self.contains(.bottomRight) {
            cornerMask.insert(.layerMaxXMaxYCorner)
        }
        return cornerMask
    }
}
