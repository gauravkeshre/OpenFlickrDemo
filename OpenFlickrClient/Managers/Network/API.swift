//
//  API.swift
//  OpenFlickrClient
//
//  Created by Gaurav Keshre on 01/07/18.
//  Copyright © 2018 Gaurav Keshre. All rights reserved.
//

import Foundation

/** This class lies at the bottom of the network layer that makes contact with underlying networking framework (in this project it is `URLSession`)
 - Important: This class has only static methods. */

final class API {
    
    static func sendRequest<R: Request, T>(request: R, onCompletion completion: @escaping CompletionCallback<T>) -> CancelableTask? {
        
        guard let url = URL(string: request.finalURL) else {
            completion(APIResult.failure(.invalidURL))
            return nil
        }
        
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error {
                completion(APIResult.failure(.custom(err.localizedDescription)))
                return
            }
            
            guard let data = data else {
                completion(APIResult.failure(.empty))
                return
            }
            handleResponse(responseData: data, onCompletion: completion)
        }
        dataTask.resume()
        return dataTask
    }
    
    
    /** A seperate static method specialized to handle the post sanitization operation of response.
     
     This encompasses:
     
         - converting `Data` to `JSONDictionary`
         - getting the `JSONDictionary` parsed to concrete object
         - executing completion call back to propogate the satus
     
     - Parameters:
     
         - response: valid `Data` passed on from `sendRequest(::)` metod
         - completion: CompletionCallback
     */
    
    static func handleResponse<T>(responseData: Data,
                                  onCompletion completion: @escaping CompletionCallback<T>){
        
        
        guard let dictionary = try? JSONSerialization.jsonObject(with: responseData, options: .allowFragments) as? JSONDictionary else {
            completion(APIResult.failure(.invalidData))
            return
        }
        
        guard let di = dictionary else{
            completion(APIResult.failure(.invalidData))
            return
        }
        let res = T.parse(dictionary: di)

        completion(APIResult.success(res))
    }
}

extension URLSessionDataTask: CancelableTask {
    func cancelTask() {
        self.cancel()
    }
}
