//
//  ImageCacheTests.swift
//  OpenFlickrClientTests
//
//  Created by Gaurav Keshre on 01/07/18.
//  Copyright © 2018 Gaurav Keshre. All rights reserved.
//

import XCTest
@testable import OpenFlickrClient


class ImageCacheTests: XCTestCase {
    private enum Keys {
        static let key1 = "test:dog1"
        static let key2 = "test:dog2"
        static let key3 = "test:cat1"
        static let key4 = "test:cat2"
    }
    private enum Images {
        static let animal1 = UIImage(named: "dog1")!
        static let animal2 = UIImage(named: "dog2")!
        static let animal3 = UIImage(named: "cat1")!
        static let animal4 = UIImage(named: "cat2")!
    }
    
    override func setUp() {
        super.setUp()

    }
    
    /** All test keys are cleared by teardown method*/
    override func tearDown() {
        super.tearDown()
        ImageCacheManager.shared.removeImage(forKey: Keys.key1, Keys.key2, Keys.key3, Keys.key4)
    }
    
    /** Add Image to cache and test */
    func testCacheHit() {
        ImageCacheManager.shared.addImage(Images.animal1, forKey: Keys.key1)
        
        let image = ImageCacheManager.shared.fetchImage(forKey: Keys.key1)
        XCTAssertNotNil(image)
        XCTAssertEqual(Images.animal1, image)
        
    }
    
    
    func testCacheMiss() {
        let image2 = ImageCacheManager.shared.fetchImage(forKey: Keys.key1)
        XCTAssertNil(image2, "Image should be nil.")
    }
    
    func testCacheAddAndRemove() {
        /** add */
        ImageCacheManager.shared.addImage(Images.animal1, forKey: Keys.key1)
        let image1 = ImageCacheManager.shared.fetchImage(forKey: Keys.key1)
        XCTAssertNotNil(image1, "Image should not be nil.")
        
        /** remove */
        ImageCacheManager.shared.removeImage(forKey: Keys.key1)
        let image2 = ImageCacheManager.shared.fetchImage(forKey: Keys.key1)
        XCTAssertNil(image2, "Image should be nil.")
    }
    
    func testCacheAddAndRemoveMultiple() {
        /** add */
        ImageCacheManager.shared.addImage(Images.animal1, forKey: Keys.key1)
        ImageCacheManager.shared.addImage(Images.animal2, forKey: Keys.key2)
        ImageCacheManager.shared.addImage(Images.animal3, forKey: Keys.key3)
        ImageCacheManager.shared.addImage(Images.animal4, forKey: Keys.key4)
        
        let image1 = ImageCacheManager.shared.fetchImage(forKey: Keys.key1)
        let image2 = ImageCacheManager.shared.fetchImage(forKey: Keys.key2)
        let image3 = ImageCacheManager.shared.fetchImage(forKey: Keys.key3)
        let image4 = ImageCacheManager.shared.fetchImage(forKey: Keys.key4)
        
        XCTAssertNotNil(image1, "Image should not be nil.")
        XCTAssertNotNil(image2, "Image should not be nil.")
        XCTAssertNotNil(image3, "Image should not be nil.")
        XCTAssertNotNil(image4, "Image should not be nil.")
        
        ImageCacheManager.shared.removeImage(forKey: Keys.key1, Keys.key2, Keys.key3, Keys.key4)
        
        let image11 = ImageCacheManager.shared.fetchImage(forKey: Keys.key1)
        let image22 = ImageCacheManager.shared.fetchImage(forKey: Keys.key2)
        let image33 = ImageCacheManager.shared.fetchImage(forKey: Keys.key3)
        let image44 = ImageCacheManager.shared.fetchImage(forKey: Keys.key4)
        
        XCTAssertNil(image11, "Image should be nil.")
        XCTAssertNil(image22, "Image should be nil.")
        XCTAssertNil(image33, "Image should be nil.")
        XCTAssertNil(image44, "Image should be nil.")

    }
    
    func testCacheOverriteImage() {
        /** TODO */
    }
   
}
