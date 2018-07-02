//
//  CollectionViewTests.swift
//  OpenFlickrClientTests
//
//  Created by Gaurav Keshre on 01/07/18.
//  Copyright © 2018 Gaurav Keshre. All rights reserved.
//

import XCTest
@testable import OpenFlickrClient


class CollectionViewTests: XCTestCase {
    
    private var collectionView: UICollectionView = {
        let frame  = CGRect(x: 0, y: 0, width: 375, height: 600)
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        
        let collection = UICollectionView(frame: frame, collectionViewLayout: layout)
        return collection
    }()
    
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    /** Checks the number of items and estimate the size of cells such that `numberOfItems` fit in one row */
    func testItemSquareSize() {
        func checkWithItemsCount(_ items: Int, expected: CGFloat, not: CGFloat) {
            let size = collectionView.itemSize(numberOfItemsPerRow: items)
            XCTAssertEqual(size.width, expected, "The item size calucation is not correct")
            XCTAssertNotEqual(size.width, not, "The item size calucation is not correct")
        }
        checkWithItemsCount( 3, expected: 111, not: 112)
        checkWithItemsCount( 4, expected: 81, not: 81.12)
    }
}
