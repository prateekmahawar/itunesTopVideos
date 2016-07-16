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
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
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
    @IBAction func socialMedia(sender: UIBarButtonItem) {
        
        
        ShareMedia()
        
    }
    
    func ShareMedia(){
        let activity1 = "Check out this great VIDEO"
        let activity2 = ("\(videos.vName) by \(videos.vArtist)")
        let activity3 = "Watch it and tell me what you think"
        let activity4 = videos.vLinkToItunes
        let activity5 = "Shared by YOURS TRULY"
        
        
        let activityViewController : UIActivityViewController = UIActivityViewController(activityItems: [activity1,activity2,activity3,activity4,activity5], applicationActivities: nil)
        
        //activityViewController.excludedActivityTypes = [UIActivityTypeMail]
        /* TYPES {UIActivityTypePrint
         UIActivityTypeCopyToPasteboard
         UIActivityTypeAssignToContact
         UIActivityTypeSaveToCameraRoll
         UIActivityTypeAddToReadingList
         UIActivityTypeAirDrop
         UIActivityTypeMessage
         UIActivityTypeMail
         UIActivityTypePostToFacebook
         UIActivityTypePostToTwitter
         UIActivityTypePostToFlickr
         UIActivityTypePostToVimeo
         UIActivityTypePostToTencentWeibo
         UIActivityTypePostToWeibo
        
         */
        presentViewController(activityViewController, animated: true, completion: nil)
        
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
