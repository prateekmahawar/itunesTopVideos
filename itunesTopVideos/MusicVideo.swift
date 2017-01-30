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
    
    
    fileprivate var _vName : String
    fileprivate var _vRights : String
    fileprivate var _vPrice : String
    fileprivate var _vImageUrl : String
    fileprivate var _vArtist : String
    fileprivate var _vVideoUrl : String
    fileprivate var _vImid : String
    fileprivate var _vGenre : String
    fileprivate var _vLinkToItunes : String
    fileprivate var _vReleaseDate : String
    
    
    var vImageData:Data?
    
  
    var vName: String {
        return _vName
    }
    
    var vImageUrl: String {
        if _vImageUrl != nil {
        return _vImageUrl
        } else {
            return "https://media0.giphy.com/media/3oEjI6SIIHBdRxXI40/200_s.gif"
        }
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
            let vName = name["label"] as? String {
            self._vName = vName
        } else {
            _vName = ""
        }
        
        if let img = data["im:image"] as? JSONArray,
            let image = img[2] as? JSONDictionary,
            let immage = image["label"] as? String {
            _vImageUrl = immage.replacingOccurrences(of: "100x100", with: "600x600")
        } else {
            _vImageUrl = ""
        }
        
        
        if let video = data["link"] as? JSONArray,
            let vUrl = video[1] as? JSONDictionary,
            let vHref = vUrl["attributes"] as? JSONDictionary,
            let vVideoUrl = vHref["href"] as? String
        {
            self._vVideoUrl = vVideoUrl
        } else {
            self._vVideoUrl = ""
        }
        
        if let Rights = data["rights"] as? JSONDictionary,
            let vRights = Rights["label"] as? String {
            self._vRights = vRights
        } else {
            self._vRights = ""
        }
        
        if let Price = data["im:price"] as? JSONDictionary,
            let vPrice = Price["label"] as? String {
            if vPrice == "Get"{
                self._vPrice = "$2.99" } else {
                self._vPrice = vPrice
            }
        } else {
            self._vPrice = ""
        }
        
        if let Artist = data["im:artist"] as? JSONDictionary,
            let vArtist = Artist["label"] as? String {
            self._vArtist = vArtist
        } else {
            self._vArtist = ""
        }
        
        if let Imid = data["id"] as? JSONDictionary,
            let vid = Imid["attributes"] as? JSONDictionary,
            let vImid = vid["im:id"] as? String {
            self._vImid = vImid
        } else {
            self._vImid = ""
        }
        
        if let Genre = data["category"] as? JSONDictionary,
            let genree = Genre["attributes"] as? JSONDictionary,
            let vGenre = genree["term"] as? String {
            self._vGenre = vGenre
        } else {
            self._vGenre = ""
        }
        
        if let link = data["link"] as? JSONArray,
            let linkk = link[0] as? JSONDictionary,
            let linkkk = linkk["attributes"] as? JSONDictionary,
            let vLinkToItunes = linkkk["href"] as? String {
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
            let image = img[2] as? JSONDictionary,
            let immage = image["label"] as? String {
            lablImage = immage
        } else {
            lablImage = ""
        }
        
    }
    
    
}
