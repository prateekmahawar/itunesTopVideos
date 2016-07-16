//
//  ViewController.swift
//  itunesTopVideos
//
//  Created by Prateek Mahawar on 12/07/16.
//  Copyright © 2016 Prateek Mahawar. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating {

    @IBOutlet weak var tableView: UITableView!
    
        var videos = [Videos]()
        //Search Start
        var filterSearch = [Videos]()
        let resultsSearchController = UISearchController(searchResultsController: nil)
        //Search Finish
    
        var limit = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = false
        tableView.dataSource = self
        tableView.delegate = self
        
        self.tableView.addSubview(self.refreshControl)
        title = ("The iTunes Top \(limit) Music Videos")
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.reachabilityStatusChanged) , name: "ReachStatusChanged", object: nil)
        
        reachabilityStatusChanged()
        
    }
    private struct storyBoard {
        static let cellReuseIdentifier = "cell"
        static let segueIdentifier = "musicDetail"
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if resultsSearchController.active{
            return filterSearch.count
        } else {
            return videos.count
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier(storyBoard.cellReuseIdentifier, forIndexPath: indexPath) as?  MusicVideoCell{
            if resultsSearchController.active {
                cell.video = filterSearch[indexPath.row]
            } else {
                cell.video = videos[indexPath.row]
            }
                return cell
        }
        else {
            return MusicVideoCell()
        }
        
    }

    
    func didLoadData(result:[Videos]) {
//                for item in videos {
//                    print("Name Of Artist = \(item.vArtist)")
//                }
        //        for i in 0  ..< videos.count  {
        //            let video = videos[i]
        //          //  print("Name Of Artist = \(video.vArtist)")
        //        }
        
        self.videos = result
        
        //Search Start
        resultsSearchController.searchResultsUpdater = self
        definesPresentationContext = true
        resultsSearchController.dimsBackgroundDuringPresentation = false //Selection Doesn't Work MOST IMPORTANT
        resultsSearchController.searchBar.placeholder = "Search Here"
        resultsSearchController.searchBar.searchBarStyle = UISearchBarStyle.Prominent //Don't Need it necessarily
        
        tableView.tableHeaderView = resultsSearchController.searchBar
        
        //Saerch Finish
        
        tableView.reloadData()
        
    }
    func reachabilityStatusChanged() {
        switch reachabilitystatus {
        case NOACCESS:
            //view.backgroundColor = UIColor.redColor()
            //Move Back to main Queue
            dispatch_async(dispatch_get_main_queue()){
            let alert = UIAlertController(title: "No Internet Access", message: "Please Make sure", preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Default) {
             action -> () in
                //Perfrom Actions
                print("Cancel")
            }
//            let deleteAction = UIAlertAction(title: "Delete", style: .Destructive) {
//                action -> () in
//                print("Delete")
//            }
            let OkAction = UIAlertAction(title: "OK", style: .Default) {
                action -> () in
                print("OK")
            }
        //order MATTERS
        alert.addAction(OkAction)
        alert.addAction(cancelAction)
     //   alert.addAction(deleteAction)
        self.presentViewController(alert, animated: true, completion: nil)
            }
        default:
            //view.backgroundColor = UIColor.greenColor()
            if videos.count > 0 {
                print("Do Not Refresh API")
                
            } else {
                
                runAPI()
            }
        }
        
        
        
    }
    
    func getAPICount(){
        if (NSUserDefaults.standardUserDefaults().objectForKey("APICNT") != nil) {
            let theValue = NSUserDefaults.standardUserDefaults().objectForKey("APICNT") as! Int
            limit = theValue
        }
        
        
    }
    
    func runAPI() {
        getAPICount()
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=\(limit)/json", completion: didLoadData)
        self.title = ("The iTunes Top \(limit) Music Videos")
    }
    
   deinit
   {
    NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == storyBoard.segueIdentifier {
            if let indexPath = tableView.indexPathForSelectedRow {
                let video: Videos
                if resultsSearchController.active{
                     video = filterSearch[indexPath.row]
                
                } else {
                     video = videos[indexPath.row]
                
                }
                let dVC = segue.destinationViewController as? DetailVC
                dVC!.videos = video
                
            }
        }
    }
    
    //Search LOGIC
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        searchController.searchBar.text!.lowercaseString
        filterSearch(searchController.searchBar.text!)
    }
    
    func filterSearch(searchText:String) {
        filterSearch = videos.filter { videos in
            return videos.vArtist.lowercaseString.containsString(searchText.lowercaseString)
        }
        tableView.reloadData()
    }
    
    
    //UIRefreshControl
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ViewController.handleRefresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        return refreshControl
    }()
    func handleRefresh(refreshControl: UIRefreshControl) {
       
        if resultsSearchController.active {
            refreshControl.endRefreshing()
        } else {
        self.tableView.reloadData()
        refreshControl.endRefreshing()
            runAPI()}
        
    }
//    override func viewWillAppear(animated: Bool) {
//        runAPI()
//    }
    
}

