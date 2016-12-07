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
        noNameLbl.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        songNameLbl.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        
        noNameLbl.text = ("\(video.vRank) . \(video.vArtist)")
        songNameLbl.text = ("\(video.vName)")
        
        if video!.vImageData != nil {
            videoImg.image = UIImage(data: video!.vImageData! as Data)
        } else {
            print("Get Image in background")
            getVideoImage(video!, imageView: videoImg)
        }
        
    }
    
    func removeImage() {
        videoImg.image = UIImage(named: "load")
    }
    
    func getVideoImage(_ video: Videos , imageView: UIImageView) {
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async {
            let data = try? Data(contentsOf: URL(string: video.vImageUrl)!)
            
            var image : UIImage?
            if data != nil {
                video.vImageData = data
                image = UIImage(data: data!)
            }
            
            DispatchQueue.main.async {
        
            imageView.image = image
        
            }
        }
    }
    
}
