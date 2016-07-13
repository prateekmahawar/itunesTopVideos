//
//  ViewController.swift
//  itunesTopVideos
//
//  Created by Prateek Mahawar on 12/07/16.
//  Copyright © 2016 Prateek Mahawar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    
        var videos = [Videos]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.reachabilityStatusChanged) , name: "ReachStatusChanged", object: nil)
        reachabilityStatusChanged()
        
        
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
        
        print(reachabilitystatus)
        self.videos = result
        for item in videos {
            print("Name Of Artist = \(item.vArtist)")
        }
        for i in 0  ..< videos.count  {
            let video = videos[i]
            print("Name Of Artist = \(video.vArtist)")
        }
        
    }
    func reachabilityStatusChanged() {
        switch reachabilitystatus {
        case NOACCESS:
            view.backgroundColor = UIColor.redColor()
            displayLabel.text = "No Internet"
        case WIFI:
            view.backgroundColor = UIColor.greenColor()
            displayLabel.text = "Wifi"
        case WWAN:
            view.backgroundColor = UIColor.yellowColor()
            displayLabel.text = "Cellular"
        default:
            return
        }
    }
   deinit
   {
    NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
    }
}

