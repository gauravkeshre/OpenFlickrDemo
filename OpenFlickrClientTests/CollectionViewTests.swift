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
        let collection = UICollectionView(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
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
        func checkWithPadding(_ padding: Int, items: Int, expected: CGFloat, not: CGFloat) {
            let size = collectionView.itemSize(numberOfItemsPerRow: items, paddingBetweenItems: padding)
            XCTAssertEqual(size.width, expected, "The item size calucation is not correct")
            XCTAssertNotEqual(size.width, not, "The item size calucation is not correct")
        }
        checkWithPadding(10, items: 3, expected: 111, not: 112)
        checkWithPadding(12, items: 4, expected: 78, not: 79)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            testItemSquareSize()
        }
    }
    
}
