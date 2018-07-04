//
//  API.swift
//  OpenFlickrClient
//
//  Created by Gaurav Keshre on 01/07/18.
//  Copyright © 2018 Gaurav Keshre. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String: Any]
typealias CompletionCallback<R: Response> = (_ response: APIResult<R>) -> ()

/** Request. A protocol that defines a somple request model. Note that this is  */
protocol Request {
    var verb: String {get set} /** GET, POST */
    var url: String {get set}
    var params: [String: Any]? {get set}
}

extension Request {
    
    /** Forms a url based on the HTTP Method.
     For this version, we only consider the GET method and rest all return the `self`
     */
    var finalURL: String {
        switch verb.lowercased() {
        case "get":
            guard let params = self.params else { return self.url}
            
            var url = self.url + "?"
            for tuple in params {
                url.append("\(tuple.key)=\(tuple.value)")
                url.append("&")
            }
            return url
        default:
            return self.url
        }
    }
}
/** A protocols that dictates how every response should be modeled. Any Class that conforms to `Response` also defines the way the json is serialized
 */
protocol Response {
    associatedtype Body
    var message: String? {get}
    var body: Body? {get}
    static func parse(dictionary: JSONDictionary) -> Self
}

enum ResponseError: Error {
    case invalidURL  /** URL was invalic */
    case empty       /** Received an empty response */
    case invalidData  /** Invalid JSON that could not be parsed */
    case unknown      /** Couldn't resolve the error */
    case custom (String)
    var message: String {
        switch self {
        case .custom(let str):
            return str
        case .empty:
            return "Received an empty response"
        case .invalidURL:
            return "There was some error in forming the request. Please try again after some time"
        case .invalidData:
            return "Invalid JSON that could not be parsed"
        default:
            return "Something went wrong"
        }
    }
    
}



/** The consumer of the service will always receive this enum. */
enum APIResult<Res: Response> {
    case failure(ResponseError)
    case success(Res)
}

protocol CancelableTask {
    func cancelTask()
}

