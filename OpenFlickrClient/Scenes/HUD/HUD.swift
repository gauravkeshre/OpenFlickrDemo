//
//  HUD.swift
//  OpenFlickrClient
//
//  Created by Gaurav Keshre on 01/07/18.
//  Copyright © 2018 Gaurav Keshre. All rights reserved.
//

import UIKit

final class HUD: UIView {
    @IBOutlet private weak var centerView : UIView!

    
    /** Instance */
    static let instance: UIView = {
        guard let view = Bundle.main.loadNibNamed("HUD", owner: self, options: nil)?.first as? UIView else{
            return UIView()
        }
        return view
    }()
    
    //MARK:- LifeCycle Method
    
    override func layoutSubviews() {
        centerView.layer.cornerRadius = centerView.bounds.width/2
        super.layoutSubviews()
    }

    
    static func show(on presenter: UIView) {
        HUD.instance.removeFromSuperview()
        HUD.instance.frame = presenter.bounds
        presenter.addSubview(HUD.instance)
    }
    
    static func show(on presenter: UIViewController) {
        show(on: presenter.view)
    }
    
    static func hide() {
        HUD.instance.removeFromSuperview()
    }
    
}

