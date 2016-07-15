//
//  ViewController.swift
//  itunesTopVideos
//
//  Created by Prateek Mahawar on 12/07/16.
//  Copyright © 2016 Prateek Mahawar. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
        var videos = [Videos]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        tableView.dataSource = self
        tableView.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.reachabilityStatusChanged) , name: "ReachStatusChanged", object: nil)
        reachabilityStatusChanged()
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let video = videos[indexPath.row]
        cell.textLabel?.text = ("\(indexPath.row+1)")
        cell.detailTextLabel?.text = video.vName
        return cell
    }

    
    func didLoadData(result:[Videos]) {
    
        print(reachabilitystatus)
        self.videos = result
        for item in videos {
            print("Name Of Artist = \(item.vArtist)")
        }
        for i in 0  ..< videos.count  {
            let video = videos[i]
            print("Name Of Artist = \(video.vArtist)")
        }
        tableView.reloadData()
        
    }
    func reachabilityStatusChanged() {
        switch reachabilitystatus {
        case NOACCESS:
            view.backgroundColor = UIColor.redColor()
            //Move Back to main Queue
            dispatch_async(dispatch_get_main_queue()){
            let alert = UIAlertController(title: "No Internet Access", message: "Please Make sure", preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Default) {
             action -> () in
                //Perfrom Actions
                print("Cancel")
            }
            let deleteAction = UIAlertAction(title: "Delete", style: .Destructive) {
                action -> () in
                print("Delete")
            }
            let OkAction = UIAlertAction(title: "ok", style: .Default) {
                action -> () in
                print("OK")
            }
        //order MATTERS
        alert.addAction(OkAction)
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        self.presentViewController(alert, animated: true, completion: nil)
            }
        default:
            view.backgroundColor = UIColor.greenColor()
            if videos.count > 0 {
                print("Do Not Refresh API")
                
            } else {
                
                runAPI()
            }
        }
        
        
        
    }
    
    func runAPI() {
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=25/json", completion: didLoadData)
    }
    
   deinit
   {
    NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
    }
    
    
    
    
    
}

