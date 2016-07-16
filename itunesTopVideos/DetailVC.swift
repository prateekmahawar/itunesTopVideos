//
//  DetailVC.swift
//  itunesTopVideos
//
//  Created by Prateek Mahawar on 15/07/16.
//  Copyright © 2016 Prateek Mahawar. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class DetailVC: UIViewController {

    var videos:Videos!
    var sec:Bool = false
    
    @IBOutlet weak var vName: UILabel!
    @IBOutlet weak var videoImg: UIImageView!
    @IBOutlet weak var vGenre: UILabel!
    @IBOutlet weak var vPrice: UILabel!
    @IBOutlet weak var vRights: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = videos.vArtist
        vName.text = videos.vName
        vPrice.text = videos.vPrice
        vRights.text = videos.vRights
        vGenre.text = videos.vGenre
        if videos.vImageData != nil {
            videoImg.image = UIImage(data: videos.vImageData!)
        } else {
            videoImg.image = UIImage(named: "1")
        }
        
    }
    @IBAction func playVideo(sender: UIBarButtonItem) {
        let url = NSURL(string: videos.vVideoUrl)!
        let player = AVPlayer(URL: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.presentViewController(playerViewController,animated:true) {
            playerViewController.player?.play()
        }
        
    }

}
