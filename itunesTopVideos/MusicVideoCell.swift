//
//  MusicVideoCell.swift
//  itunesTopVideos
//
//  Created by Prateek Mahawar on 15/07/16.
//  Copyright © 2016 Prateek Mahawar. All rights reserved.
//

import UIKit

class MusicVideoCell: UITableViewCell {
    
    var video : Videos! {
        didSet {
            updateCell()
        }
    }
    
    @IBOutlet weak var videoImg: UIImageView!
    @IBOutlet weak var noNameLbl: UILabel!
    @IBOutlet weak var songNameLbl: UILabel!

    
    func updateCell(){
//        videoImg.image = UIImage(named: "1")
        noNameLbl.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        songNameLbl.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        
        noNameLbl.text = ("\(video.vRank) . \(video.vArtist)")
        songNameLbl.text = ("\(video.vName)")
    
        if video!.vImageData != nil {
            videoImg.image = UIImage(data: video!.vImageData!)
        } else {
            print("Get Image in background")
            getVideoImage(video!, imageView: videoImg)
        }
        
    }
    
    func getVideoImage(video: Videos , imageView: UIImageView) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let data = NSData(contentsOfURL: NSURL(string: video.vImageUrl)!)
            
            var image : UIImage?
            if data != nil {
                video.vImageData = data
                image = UIImage(data: data!)
            }
            
            dispatch_async(dispatch_get_main_queue()) {
        
            imageView.image = image
        
            }
        }
    }
    
}
