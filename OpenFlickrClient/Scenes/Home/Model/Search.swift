//
//  Search.swift
//  OpenFlickrClient
//
//  Created by Gaurav Keshre on 06/07/18.
//  Copyright © 2018 Gaurav Keshre. All rights reserved.
//

import Foundation



/** A type that encapsulate user's search. This is represnted by keyword and a cursor to the page number  */
struct Search: Equatable {
    let keyword: String
    var pageNumber: Int = -1
    
    
    /** A handy mutating method that increments the cursor to next page. This method
     
     - Important:
     It is important to be careful to only call this method after the previous page was loaded successfully.
    */
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
