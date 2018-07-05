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
    
    @discardableResult
    mutating func incrementPage() -> Search {
        pageNumber = pageNumber + 1
        return self
    }
    
    /** Equatable */
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
    
    private var service: ServiceProtocol.Type!
    
    /** DataStore */
    private var arrPhotos: [FlickrPhoto] = []
    private var currentSearch: Search!
    
    private lazy var cellSize: CGSize = {
        return self.collectionView.itemSize(numberOfItemsPerRow: Constants.CellsPerRow)
    }()
    
    private lazy var headerSize: CGSize = {
        var size = collectionView.bounds.size
        size.width = size.width - CGFloat( 2 * Constants.PaddingBetweenItems)
        size.height = 110
        return size
    }()
    

    
    //MARK:- LifeCycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /** Inject Default Service */
        self.service = FlickrService.self
        
        /** UITextField UI Setup */
        let image = UIImage(named: "icons8-search")?.withRenderingMode(.alwaysTemplate)
        self.txtSearch.addLeftImage(image, tint: UIColor.lightGray.withAlphaComponent(0.5))
        
        
        
        /** Fetch Intial images with "popular tag" */
        txtSearch.text = "popular"
        triggerSearch(Search(keyword: "popular", pageNumber: 1))
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        txtSearch.decorateWithCornerRadius()
        
    }
}

/** Search */
private extension ImageSearchController {
    
    func triggerSearch(_ search: Search, showHUD: Bool = true) {
        func toggleHUD(visible: Bool = true) {
            guard showHUD else { return }
            HUD.toggle(to: visible, on: self)
        }
        
        /** Check if this is just a page number update or a new keyword.
                if this is a new keyword, we will not append new results in existing array but just refresh the array
         */
        let refresh = search != currentSearch
        if refresh {
            self.currentSearch = search
        }
        
        task?.cancelTask()
        toggleHUD()
        task = service.fetchFlickrPhoto(tag: search.keyword, page: search.pageNumber) { (result) in
            switch result {
            case .success( let response):
                guard let photos = response.body?.photos else {
                    // Error Handling here.
                    toggleHUD(visible: false)
                    return
                }
                
                /** Increment only if the request was successfull */
                self.currentSearch.incrementPage()
                
                
                
                toggleHUD(visible: false)
                
               
                
                DispatchQueue.main.async {
                    /** If this was a fresh search. Just clean existing data source array */
                    if refresh {
                        self.arrPhotos.removeAll()
                        self.arrPhotos.append(contentsOf: photos)
                        self.collectionView.reloadData()
                        return
                    }
                    
                    self.collectionView.performBatchUpdates({
                        
                        /** Insert new indexPaths in the collectionview. that offsets from `arrPhotos.count` till new  `arrPhotos.count + photos. count -1` */
                        let startIndex = self.arrPhotos.count
                        
                        self.arrPhotos.append(contentsOf: photos)
                        let endIndex = self.arrPhotos.count - 1

                        let indexPaths = Array(startIndex...endIndex).map { IndexPath(item: $0, section: 1) }
                        self.collectionView.insertItems(at: indexPaths)
                    }, completion: nil)
                }
                
            case .failure (let err):
                print("error: \(err.message)")
                toggleHUD(visible: false)
            }
        }
    }
}
/** Actions */
private extension ImageSearchController {
    @IBAction
    func handleTap(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction
    func handleGoButton(_ sender: UIButton) {
        guard let text = txtSearch.text, text.count > 1 else {
            return
        }
        
        triggerSearch(Search(keyword: text, pageNumber: 1))
    }
}

/** UITextField Protocol conformation */
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

/** UICollectionView Protocol conformation */
extension ImageSearchController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //MARK:- UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 1 : arrPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        /** Header Cell */
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCell", for: indexPath)
            return cell
        }
        
        /** Image Cell */
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        cell.configure(arrPhotos[indexPath.item])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
        guard arrPhotos.count > 0 else  { return }
        guard indexPath.section == 1 else { return }
        
        if indexPath.row >= arrPhotos.count -  (  3 * Constants.CellsPerRow) - 1 {
            triggerSearch(currentSearch, showHUD: false)
        }
    }
    
    //MARK:- UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return indexPath.section == 0 ? headerSize : cellSize
    }
    
    
}
