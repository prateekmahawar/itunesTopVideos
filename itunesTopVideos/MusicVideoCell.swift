//
//  MusicVideoCell.swift
//  itunesTopVideos
//
//  Created by Prateek Mahawar on 15/07/16.
//  Copyright © 2016 Prateek Mahawar. All rights reserved.
//

import UIKit
import Nuke

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
        
        
        videoImg.image = UIImage(named: "1")
//        videoImg.downloadImageFrom(link: video.vImageUrl, contentMode: .scaleAspectFit)
        let fileUrl = NSURL(string: video.vImageUrl)
        var urlRequest = URLRequest(url: fileUrl as! URL)
        urlRequest.cachePolicy = .reloadIgnoringLocalCacheData
        urlRequest.timeoutInterval = 30
        let request = Request(urlRequest: urlRequest)
        Nuke.loadImage(with: request, into: videoImg)


        videoImg.layer.masksToBounds = true
        
    }
    
    func removeImage() {
        videoImg.image = UIImage(named: "1")
    }
    

}
