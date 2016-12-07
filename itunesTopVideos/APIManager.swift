//
//  APIManager.swift
//  itunesTopVideos
//
//  Created by Prateek Mahawar on 12/07/16.
//  Copyright © 2016 Prateek Mahawar. All rights reserved.
//

import Foundation

class APIManager {
    
    func loadData(_ urlString:String , completion: @escaping ([Videos]) -> Void) {
        
        let config = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: config)
        
//        let session = NSURLSession.sharedSession()
        let url = URL(string: urlString)!
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) -> Void in
            if error != nil {
                print(error!.localizedDescription)
                }
             else {
                
                do {
    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? JSONDictionary, let feed = json["feed"] as? JSONDictionary, let entries = feed["entry"] as? JSONArray {
        
        var videos = [Videos]()
        for (index,entry) in entries.enumerated() {
            let entry = Videos(data: entry as! JSONDictionary)
            entry.vRank = index + 1
            videos.append(entry)
        }
                let i = videos.count
        print("Itunes top \(i)")
        print (" ")
        let priority = DispatchQueue.GlobalQueuePriority.default
        DispatchQueue.global(priority: priority).async {
            DispatchQueue.main.async {
                completion(videos)
            }
        }
        
                    }} catch {
                print("APIManager problem")
        }
                }
        }) 

        task.resume()
    }
}
