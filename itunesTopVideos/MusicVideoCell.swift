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

    @IBOutlet weak var priceLbl: UILabel!
    
    func updateCell(){
        videoImg.image = UIImage(named: "1")
        noNameLbl.text = ("\(video.vRank) . \(video.vArtist)")
        songNameLbl.text = ("\(video.vName)")
        priceLbl.text = ("\(video.vPrice)")
        
    }
    
}
