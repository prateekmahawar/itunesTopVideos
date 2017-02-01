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
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.reachabilityStatusChanged) , name: NSNotification.Name(rawValue: "ReachStatusChanged"), object: nil)
        
        reachabilityStatusChanged()
        
    }
    fileprivate struct storyBoard {
        static let cellReuseIdentifier = "cell"
        static let segueIdentifier = "musicDetail"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if resultsSearchController.isActive{
            return filterSearch.count
        } else {
            return videos.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: storyBoard.cellReuseIdentifier, for: indexPath) as?  MusicVideoCell{
            if resultsSearchController.isActive {
                cell.video = filterSearch[indexPath.row]
            } else {
                cell.video = videos[indexPath.row]
            }
            
            //Add Shadow
//            let shadowPath2: UIBezierPath = UIBezierPath(rect: cell.bounds)
//            cell.layer.masksToBounds = false
//            cell.layer.shadowColor = UIColor.blackColor().CGColor
//            cell.layer.shadowOffset = CGSizeMake(0.0, 5.0)
//            cell.layer.shadowOpacity = 0.5
//            cell.layer.shadowPath = shadowPath2.CGPath

            
            //Add Separator
            let separatorLineView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 3))

            separatorLineView.backgroundColor = UIColor.white
            
            cell.contentView.addSubview(separatorLineView)

                return cell
        }
        else {
            return MusicVideoCell()
            
        }
        
    }

    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? MusicVideoCell else { return }
        
            cell.removeImage()
        }
    

    func didLoadData(_ result:[Videos]) {
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
        resultsSearchController.searchBar.searchBarStyle = UISearchBarStyle.prominent //Don't Need it necessarily
        
        tableView.tableHeaderView = resultsSearchController.searchBar
        
        //Saerch Finish
        
        tableView.reloadData()
        
    }
    func reachabilityStatusChanged() {
        switch reachabilitystatus {
        case NOACCESS:
            //view.backgroundColor = UIColor.redColor()
            //Move Back to main Queue
            DispatchQueue.main.async{
            let alert = UIAlertController(title: "No Internet Access", message: "Please Make sure internet is available", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .default) {
             action -> () in
                //Perfrom Actions
                print("Cancel")
            }
//            let deleteAction = UIAlertAction(title: "Delete", style: .Destructive) {
//                action -> () in
//                print("Delete")
//            }
            let OkAction = UIAlertAction(title: "OK", style: .default) {
                action -> () in
                print("OK")
            }
        //order MATTERS
        alert.addAction(OkAction)
        alert.addAction(cancelAction)
     //   alert.addAction(deleteAction)
        self.present(alert, animated: true, completion: nil)
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
        if (UserDefaults.standard.object(forKey: "APICNT") != nil) {
            let theValue = UserDefaults.standard.object(forKey: "APICNT") as! Int
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
    NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "ReachStatusChanged"), object: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == storyBoard.segueIdentifier {
            if let indexPath = tableView.indexPathForSelectedRow {
                let video: Videos
                if resultsSearchController.isActive{
                     video = filterSearch[indexPath.row]
                
                } else {
                     video = videos[indexPath.row]
                
                }
                let dVC = segue.destination as? DetailVC
                dVC!.videos = video
                
            }
        }
    }
    
    //Search LOGIC
    func updateSearchResults(for searchController: UISearchController) {
//        searchController.searchBar.text!.lowercased()
        filterSearch(searchController.searchBar.text!.lowercased())
    }
    
    func filterSearch(_ searchText:String) {
        filterSearch = videos.filter { videos in
            return videos.vArtist.lowercased().contains(searchText.lowercased()) || videos.vName.lowercased().contains(searchText.lowercased()) || "\(videos.vRank)".lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
    }
    
    
    //UIRefreshControl
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        
        return refreshControl
    }()
    func handleRefresh(_ refreshControl: UIRefreshControl) {
       
        if resultsSearchController.isActive {
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

