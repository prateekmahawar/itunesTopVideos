//
//  MusicVideo.swift
//  itunesTopVideos
//
//  Created by Prateek Mahawar on 13/07/16.
//  Copyright © 2016 Prateek Mahawar. All rights reserved.
//

import Foundation

class Videos {
    
    var vRank = 0
    var lablImage :String
    
    
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
    
    
    var vImageData:NSData?
    
  
    var vName: String {
        return _vName
    }
    
    var vImageUrl: String {
        return _vImageUrl
    }
    
    var vVideoUrl:String {
        return _vVideoUrl
    }
    
    var vPrice : String {
        return _vPrice
    }
    
    var vRights : String {
        return _vRights
    }
    
    var vArtist : String {
        return _vArtist
    }
    
    var vImid : String {
        return _vImid
    }
    
    var vGenre : String {
        return _vGenre
    }
    
    var vLinkToItunes : String {
        return _vLinkToItunes
    }
    var vReleaseDate: String {
        return _vReleaseDate
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
            if vPrice == "Get"{
                self._vPrice = "$2.99" } else {
                self._vPrice = vPrice
            }
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
            vid = Imid["attributes"] as? JSONDictionary,
            vImid = vid["im:id"] as? String {
            self._vImid = vImid
        } else {
            self._vImid = ""
        }
        
        if let Genre = data["category"] as? JSONDictionary,
            genree = Genre["attributes"] as? JSONDictionary,
            vGenre = genree["term"] as? String {
            self._vGenre = vGenre
        } else {
            self._vGenre = ""
        }
        
        if let link = data["link"] as? JSONArray,
            linkk = link[0] as? JSONDictionary,
            linkkk = linkk["attributes"] as? JSONDictionary,
            vLinkToItunes = linkkk["href"] as? String {
            self._vLinkToItunes = vLinkToItunes
        } else {
            self._vLinkToItunes = ""
        }
        
        if let release = data["im:releaseDate"] as? JSONDictionary,
            let releasee = release["attributes"] as? JSONDictionary,
            let releaseDate = releasee["label"] as? String {
            self._vReleaseDate = releaseDate
        } else {
            self._vReleaseDate = ""
        }
        
        if let img = data["im:image"] as? JSONArray,
            image = img[2] as? JSONDictionary,
            immage = image["label"] as? String {
            lablImage = immage
        } else {
            lablImage = ""
        }
        
    }
    
    
}