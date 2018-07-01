//
//  ImageSearchController.swift
//  OpenFlickrClient
//
//  Created by Gaurav Keshre on 01/07/18.
//  Copyright © 2018 Gaurav Keshre. All rights reserved.
//

import UIKit

struct Search: Equatable {
    let keyword: String
    var pageNumber: Int = -1
    
    static func == (lhs: Search, rhs: Search) -> Bool {
        return lhs.keyword == rhs.keyword
    }
}

final class ImageSearchController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet private weak var collectionView : UICollectionView!
    @IBOutlet private weak var txtSearch : UITextField!
    @IBOutlet private weak var btnGo : UIButton!

    
    //MARK:- Private Props
    /** Keeping track of the presently running `NSURLSessionTask`. We will need to cancel the presnet task as the user types and enters */
    private var task: CancelableTask?
    
    /** DataStore */
    private var arrPhotos: [FlickrPhoto] = []
    private var currentSearch: Search!
    
    private lazy var cellSize: CGSize = {
        return self.collectionView.itemSize(numberOfItemsPerRow: Constants.CellsPerRow, paddingBetweenItems: Constants.PaddingBetweenItems)
    }()
    //MARK:- Public Props
    
    
    //MARK:- LifeCycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        /** UITextField UI Setup */
        let image = UIImage(named: "icons8-search")?.withRenderingMode(.alwaysTemplate)
        self.txtSearch.addLeftImage(image, tint: UIColor.lightGray.withAlphaComponent(0.5))
        txtSearch.decorateWithCornerRadius()
        
        
        /** Fetch Intial images with "popular tag" */
        txtSearch.text = "popular"
        triggerSearch(Search(keyword: "popular", pageNumber: 1))
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

/** Search */
extension ImageSearchController {
    
    func triggerSearch(_ search: Search) {
        
        let refresh = search != currentSearch
        
        if refresh {
            currentSearch = search
        }else {
            currentSearch.pageNumber += 1
        }
        
        task?.cancelTask()
        
        task = FlickrService.fetchFlickrPhoto(tag: search.keyword, page: search.pageNumber) { (result) in
            switch result {
            case .success( let response):
                guard let photos = response.body?.photos else {
                    // Error Handling here.
                    return
                }
                if refresh {
                    self.arrPhotos.removeAll()
                }
                self.arrPhotos.append(contentsOf: photos)
                DispatchQueue.main.async {
                    // to be improved
                    self.collectionView.reloadData()
                }
            case .failure (let err):
                print("error: \(err.message)")
            }
        }
    }
}
/** Actions */
extension ImageSearchController {
    @IBAction
    func handleTap(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction
    func handleGoButton(_ sender: UIButton) {
        guard let text = txtSearch.text, text.count > 0 else {
            return
        }
        triggerSearch(Search(keyword: text, pageNumber: 1))
        
    }
}

/** UITextField */
extension ImageSearchController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        guard let keyword = textField.text, keyword.count >= 2 else {
            return true
        }
        
        triggerSearch(Search(keyword: keyword, pageNumber: 1))
        
        return true
    }
}

/** UICollectionView */
extension ImageSearchController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    //MARK:- UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return section == 0 ? 1 : arrPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCell", for: indexPath)
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        cell.configure(arrPhotos[indexPath.item])
        return cell
    }
    
    
    //MARK:- UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            var size = collectionView.bounds.size
            size.width = size.width - CGFloat( 2 * Constants.PaddingBetweenItems)
            size.height = 0
            return size
        }
        return cellSize
    }
    
    
}
