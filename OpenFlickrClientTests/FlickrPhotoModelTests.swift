//
//  FlickrPhotoModelTests.swift
//  OpenFlickrClientTests
//
//  Created by Gaurav Keshre on 05/07/18.
//  Copyright © 2018 Gaurav Keshre. All rights reserved.
//

import XCTest
@testable import OpenFlickrClient


class FlickrPhotoModelTests: XCTestCase {

    
    override func setUp() {
        super.setUp()
        /** We want the freshly parsed data for every test method.  */
    }
    
    //MARK:- Happy Dataset
    func testSerialization_happy() {
        let resultModel  = MockData.imageResultModel(for: .happy)!
        XCTAssertNotNil(resultModel)
    }
    
    func testFlickrPhotosResultModel_happy () {
        let resultModel  = MockData.imageResultModel(for: .happy)!

        XCTAssertEqual(resultModel.pageNumber,  20)
        XCTAssertEqual(resultModel.numberOfPhotosPerPage,  100)
        XCTAssertEqual(resultModel.totalPages,  6997.0)
        XCTAssertEqual(resultModel.totalPhotos,  699672.0)
        XCTAssertEqual(resultModel.photos.count,  5)
    }
    
    func testFlickrPhotoModel_happy () {
        let resultModel  = MockData.imageResultModel(for: .happy)!
        let model = resultModel.photos.first!
        
        XCTAssertNotNil(model)
        XCTAssertEqual(model.id, "42272571325")
        XCTAssertEqual(model.owner, "85921430@N02")
        XCTAssertEqual(model.secret, "26abc28e76")
        XCTAssertEqual(model.server, "1765")
        XCTAssertEqual(model.farm, 2)
        XCTAssertEqual(model.title, "Deputada Janete de Sá - Sessão Ordinária + Tribuna Popular - 03.07.2018")
        XCTAssertEqual(model.isPublic, true)
        XCTAssertEqual(model.isFriend, false)
        XCTAssertEqual(model.isFamily, false)
    }
    
    func testFlickrPhotoURLConstruction_happy () {
        let resultModel  = MockData.imageResultModel(for: .happy)!
        let model = resultModel.photos.last!
        
        XCTAssertNotNil(model)
        
        let sut = "http://farm\(model.farm).static.flickr.com/\(model.server)/\(model.id)_\(model.secret).jpg"
        let expectation = "http://farm1.static.flickr.com/913/42272569085_e18b0f5c83.jpg"
        XCTAssertEqual(sut, expectation)
    }
    
    //MARK:- Empty Dataset

    func testSerialization_empty() {
        let resultModel  = MockData.imageResultModel(for: .empty)
        XCTAssertNil(resultModel)
    }
    
    
    //MARK:- ResultWithoutPhotos
    func testSerialization_noPhotos() {
        
        let resultModel = MockData.imageResultModel(for: .resultWithoutPhotos)
        XCTAssertNotNil(resultModel)
    }
    
    
    func testFlickrPhotosResultModel_noPhotos() {
        let resultModel  = MockData.imageResultModel(for: .resultWithoutPhotos)!
        
        XCTAssertEqual(resultModel.pageNumber,  20)
        XCTAssertEqual(resultModel.numberOfPhotosPerPage,  100)
        XCTAssertEqual(resultModel.totalPages,  6997.0)
        XCTAssertEqual(resultModel.totalPhotos,  699672.0)

        XCTAssertNotNil(resultModel.photos)
        XCTAssertEqual(resultModel.photos.count,  0)
    }
    
    //MARK:- MissingValues
    func testSerialization_missingValues() {
        let resultModel = MockData.imageResultModel(for: .missingValues)
        XCTAssertNotNil(resultModel)
    }
    
    func testFlickrPhotosResultModel_missingValues() {
        let resultModel  = MockData.imageResultModel(for: .missingValues)!
        
        XCTAssertEqual(resultModel.pageNumber,  -1)
        XCTAssertEqual(resultModel.numberOfPhotosPerPage,  -1)
        XCTAssertEqual(resultModel.totalPages,  -1)
        XCTAssertEqual(resultModel.totalPhotos,  -1)
        
        XCTAssertNotNil(resultModel.photos)
        XCTAssertEqual(resultModel.photos.count,  0)
    }
    
}
