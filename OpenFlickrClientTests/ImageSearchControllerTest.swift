//
//  ImageSearchControllerTest.swift
//  OpenFlickrClientTests
//
//  Created by Gaurav Keshre on 04/07/18.
//  Copyright © 2018 Gaurav Keshre. All rights reserved.
//

import XCTest
@testable import OpenFlickrClient

/** Tests some aspects of  `ImageSearchController`*/
class ImageSearchControllerTest: XCTestCase {
    
    var viewController: ImageSearchController!
    
    /** We need the fresh controller object before every test method */
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: ImageSearchController = storyboard.instantiateViewController(withIdentifier: "ImageSearchController") as! ImageSearchController
        viewController = vc
        _ = viewController.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        viewController = nil
    }
    
    func testInitialization() {
        XCTAssertNotNil(viewController)
    }
    
    func testView() {
        XCTAssertNotNil(viewController.testable_collectionView)
        XCTAssertEqual(viewController.testable_collectionView.numberOfSections, 2)
        XCTAssertNotNil(self.viewController.testable_txtSearch.text)
        XCTAssertEqual(self.viewController.testable_txtSearch.text, "popular")
    }
    
    func testData() {
        viewController.service =  MockServiceSuccess.self
        let search = Search(keyword: "dog", pageNumber: 1)
        
        let desc = "Call API and wait for UI to render the data"
        let expectation = self.expectation(description: desc)
        
        
        viewController.testable_triggerSearch(search, showHUD: false) {
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 10) { error in
            XCTAssertNil(error)
            XCTAssertNotNil(self.viewController.testable_txtSearch.text)
            XCTAssertEqual(self.viewController.testable_txtSearch.text, "popular")
            XCTAssertEqual(self.viewController.testable_currentSearch.pageNumber, 2)
            XCTAssertEqual(self.viewController.testable_collectionView.numberOfItems(inSection: 1), 5)
        }
    }
    
    /*
     
     //TODO: - Need to perfect it. the pagination call from the `willDisplayCell` method is messing up with the pagination call
    func testDataPagination() {
    
        viewController.service =  MockServiceSuccess.self
      
        var search = Search(keyword: "dragon", pageNumber: 1)
        
        let desc = "Call API and wait for UI to render the data - 1"
        let expectation1 = self.expectation(description: desc)
        
        viewController.testable_triggerSearch(search, showHUD: false) {
            expectation1.fulfill()
        }
        self.wait(for: [expectation1], timeout: 1)

        let desc2 = "Call API and wait for UI to render the data - 2"
        let expectation2 = self.expectation(description: desc2)

        search.incrementPage()
        self.viewController.testable_triggerSearch(search, showHUD: false) {
            expectation2.fulfill()
        }
        
        self.waitForExpectations(timeout: 2) { error in
            XCTAssertNil(error)
            XCTAssertEqual(self.viewController.testable_collectionView.numberOfItems(inSection: 1), 5)
        }
    }
 */
}
