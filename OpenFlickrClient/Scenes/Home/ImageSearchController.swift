//
//  ImageSearchController.swift
//  OpenFlickrClient
//
//  Created by Gaurav Keshre on 01/07/18.
//  Copyright © 2018 Gaurav Keshre. All rights reserved.
//

import UIKit


final class ImageSearchController: UIViewController {
    @IBOutlet private weak var collectionView : UICollectionView!
    @IBOutlet private weak var txtSearch : UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImage(named: "icons8-search")?.withRenderingMode(.alwaysTemplate)
        self.txtSearch.addLeftImage(image, tint: UIColor.lightGray.withAlphaComponent(0.5))
        txtSearch.decorateWithCornerRadius()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
/** Actions */
extension ImageSearchController {
    @IBAction
    func handleTap(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
}

/** UITextField */
extension ImageSearchController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
    }
}

/** UICollectionView */
extension ImageSearchController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    //MARK:- UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        return cell
    }
    
    
    //MARK:- UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .zero
    }
    
    
}
