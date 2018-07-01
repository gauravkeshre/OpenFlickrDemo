//
//  ImageSearchController.swift
//  OpenFlickrClient
//
//  Created by Gaurav Keshre on 01/07/18.
//  Copyright © 2018 Gaurav Keshre. All rights reserved.
//

import UIKit


final class ImageSearchController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet private weak var collectionView : UICollectionView!
    @IBOutlet private weak var txtSearch : UITextField!
    
    
    //MARK:- Private Props
    /** Keeping track of the presently running `NSURLSessionTask`. We will need to cancel the presnet task as the user types and enters */
    private var task: CancelableTask?
    
    /** DataStore */
    private var arrPhotos: [FlickrPhoto] = []
    
    
    private lazy var cellSize: CGSize = {
        return self.collectionView.itemSize(numberOfItemsPerRow: Constants.CellsPerRow, paddingBetweenItems: Constants.PaddingBetweenItems)
    }()
    //MARK:- Public Props
    
    
    //MARK:- LifeCycle Method
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
        
        textField.resignFirstResponder()
        
        task?.cancelTask()
        
        task = FlickrService.fetchFlickrPhoto(tag: "dogs", page: 1) { (result) in
            switch result {
            case .success( let response):
                if let photos = response.body?.photos {
                    self.arrPhotos.append(contentsOf: photos)
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            case .failure (let err):
                print("error: \(err.message)")
            }
        }
        return true
    }
}

/** UICollectionView */
extension ImageSearchController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    //MARK:- UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        cell.configure(arrPhotos[indexPath.item])
        return cell
    }
    
    
    //MARK:- UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize
    }
    
    
}
