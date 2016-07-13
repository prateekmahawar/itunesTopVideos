//
//  ViewController.swift
//  itunesTopVideos
//
//  Created by Prateek Mahawar on 12/07/16.
//  Copyright © 2016 Prateek Mahawar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

        var videos = [Videos]()
    override func viewDidLoad() {
        super.viewDidLoad()
    
    let api = APIManager()
    api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: didLoadData)
    }
    
    func didLoadData(result:[Videos]) {
        
//        let alert = UIAlertController(title: (result), message: nil, preferredStyle: .Alert)
//        let okAction = UIAlertAction(title: "OK", style: .Default) {action -> () in
//            //Perform Functions
//        }
//        alert.addAction(okAction)
//        self.presentViewController(alert, animated: true, completion: nil)
        self.videos = result
        for item in videos {
            print("Name Of Artist = \(item.vArtist)")
        }
        for i in 0  ..< videos.count  {
            let video = videos[i]
            print("Name Of Artist = \(video.vArtist)")
        }
        
    }
   
}

