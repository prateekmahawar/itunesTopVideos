//
//  MusicVideo.swift
//  itunesTopVideos
//
//  Created by Prateek Mahawar on 13/07/16.
//  Copyright © 2016 Prateek Mahawar. All rights reserved.
//

import Foundation

class Videos {
    private var _vName : String
    private var _vRights : String
    private var _vPrice : String
    private var _vImageUrl : String
    private var _vArtist : String
    private var _vVideoUrl : String
    private var _vImid : String
    private var _vGenre : String
    private var _vLinkToItunes : String
    private var _vReleaseDate : String
    
    
    var vName: String {
        return _vName
    }
    
    var vImageUrl: String {
        return _vImageUrl
    }
    
    var vVideoUrl:String {
        return _vVideoUrl
    }
    
    init (data:JSONDictionary) {
        
        if let name = data["im:name"] as? JSONDictionary,
            vName = name["label"] as? String {
            self._vName = vName
        } else {
            _vName = ""
        }
        
        if let img = data["im:image"] as? JSONArray,
            image = img[2] as? JSONDictionary,
            immage = image["label"] as? String {
            _vImageUrl = immage.stringByReplacingOccurrencesOfString("100x100", withString: "600x600")
        } else {
            _vImageUrl = ""
        }
        
        
        if let video = data["link"] as? JSONArray,
            vUrl = video[1] as? JSONDictionary,
            vHref = vUrl["attributes"] as? JSONDictionary,
            vVideoUrl = vHref["href"] as? String
        {
            self._vVideoUrl = vVideoUrl
        } else {
            self._vVideoUrl = ""
        }
        
        if let Rights = data["rights"] as? JSONDictionary,
            vRights = Rights["label"] as? String {
            self._vRights = vRights
        } else {
            self._vRights = ""
        }
        
        if let Price = data["im:price"] as? JSONDictionary,
            vPrice = Price["label"] as? String {
            self._vPrice = vPrice
        } else {
            self._vPrice = ""
        }
        
        if let Artist = data["im:artist"] as? JSONDictionary,
            vArtist = Artist["label"] as? String {
            self._vArtist = vArtist
        } else {
            self._vArtist = ""
        }
        
        if let Imid = data["id"] as? JSONDictionary,
            vImid = Imid["label"] as? String {
            self._vImid = vImid
        } else {
            self._vImid = ""
        }
        
        if let Genre = data["category"] as? NSDictionary,
            genree = Genre["attributes"] as? NSDictionary,
            vGenre = genree["term"] as? String {
            self._vGenre = vGenre
        } else {
            self._vGenre = ""
        }
        
        if let link = data["link"] as? NSArray,
            linkk = link[0] as? NSDictionary,
            linkkk = linkk["attributes"] as? NSDictionary,
            vLinkToItunes = linkkk["href"] as? String {
            self._vLinkToItunes = vLinkToItunes
        } else {
            self._vLinkToItunes = ""
        }
        
        if let release = data["im:releaseDate"] as? NSDictionary,
            let releasee = release["attributes"] as? NSDictionary,
            let releaseDate = releasee["label"] as? String {
            self._vReleaseDate = releaseDate
        } else {
            self._vReleaseDate = ""
        }
        
    }
    
    
}