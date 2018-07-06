//
//  HUD.swift
//  OpenFlickrClient
//
//  Created by Gaurav Keshre on 01/07/18.
//  Copyright © 2018 Gaurav Keshre. All rights reserved.
//

import UIKit

/** A simple make-shift HUD class.
 It adds itself as subview to the `presenter`
 */
final class HUD: UIView {
    @IBOutlet private weak var centerView : UIView!
    
    
    /** Singleton instance */
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
    
    
    /** Adds itself as a subview to the presenter. It takes the bounds of the presenter
   
     - Parameters:
        - presenter: UIView desired parent view for te HUD
     */
    static func show(on presenter: UIView) {
        DispatchQueue.main.async {
            HUD.instance.removeFromSuperview()
            HUD.instance.frame = presenter.bounds
            presenter.addSubview(HUD.instance)
        }
    }
    
   
    /** Adds itself as a subview to the presenter's view. It takes the bounds of the presenter
     
     - Parameters:
     - presenter: UIViewController controller's view is the desired parent view for te HUD
     */
    static func show(on presenter: UIViewController) {
        show(on: presenter.view)
    }
    
    /** Removes itself from superview to the presenter's view if the HUD's superview is same as presneter's view
     
     - Parameters:
     - presenter: UIViewController
     */
    static func hide(from presenter: UIViewController) {
        hide(from: presenter.view)
    }

    
    /** Removes itself from superview to the presenter's view if the HUD's superview is same as presneter
     
     - Parameters:
     - presenter: UIView
     */
    static func hide(from presenter: UIView) {
        DispatchQueue.main.async {
            guard HUD.instance.superview == presenter else { return }
            HUD.instance.removeFromSuperview()
        }
    }
}


extension HUD {
    
    /** A handly wrapper to toggle the visiblity of the HUD based on Boolean input. It returns if the HUD's superview is not same as presneter's view
     
     - Parameters:
     - shouldShow: Bool true if we need to show the HUD
     - presenter: UIViewController controller's view is the superview
     */
    static func toggle(to shouldShow: Bool, on presenter: UIViewController) {
        DispatchQueue.main.async {
            guard HUD.instance.superview == presenter.view else { return }
        }
        if shouldShow {
            show(on: presenter)
        }else {
            hide(from: presenter)
        }
    }
}
