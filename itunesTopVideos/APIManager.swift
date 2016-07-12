//
//  APIManager.swift
//  itunesTopVideos
//
//  Created by Prateek Mahawar on 12/07/16.
//  Copyright © 2016 Prateek Mahawar. All rights reserved.
//

import Foundation

class APIManager {
    
    func loadData(urlString:String , completion: (result:String) -> Void) {
        
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
//        let session = NSURLSession.sharedSession()
        let url = NSURL(string: urlString)!
        
        let task = session.dataTaskWithURL(url) {
            (data, response, error) -> Void in
            if error != nil {
                dispatch_async(dispatch_get_main_queue()) {
                    completion(result: (error!.localizedDescription))
                }
            } else {
                print(data)
                do {
    if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? JSONDictionary {
                        print(json)
                        
                        let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                        dispatch_async(dispatch_get_global_queue(priority,0)) {
                            dispatch_async(dispatch_get_main_queue()) {
                                completion(result: "JSONSERILIZATION succesful")
                            }
                        }
                    }
            } catch {
                    dispatch_async(dispatch_get_main_queue()) {
                        completion(result: "error in serialization")
                    }
                }
        }
}
        task.resume()
    }
}