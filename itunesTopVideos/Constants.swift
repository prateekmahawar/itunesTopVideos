//
//  Constants.swift
//  itunesTopVideos
//
//  Created by Prateek Mahawar on 13/07/16.
//  Copyright © 2016 Prateek Mahawar. All rights reserved.
//

import Foundation
import UIKit //For Device Version

typealias JSONDictionary = [String: AnyObject]

typealias JSONArray = Array<AnyObject>

let WIFI = "Wifi Available"

let NOACCESS = "No Internet Access"

let WWAN = "Cellular Access Available"

var systemVersion = UIDevice.currentDevice().systemVersion

public extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 where value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,3", "iPad6,4", "iPad6,7", "iPad6,8":return "iPad Pro"
        case "AppleTV5,3":                              return "Apple TV"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
    
}

//
//class ProgressIndicator: UIView {
//    
//    var indicatorColor:UIColor
//    var loadingViewColor:UIColor
//    var loadingMessage:String
//    var messageFrame = UIView()
//    var activityIndicator = UIActivityIndicatorView()
//    
//    init(inview:UIView,loadingViewColor:UIColor,indicatorColor:UIColor,msg:String){
//        
//        self.indicatorColor = indicatorColor
//        self.loadingViewColor = loadingViewColor
//        self.loadingMessage = msg
//        super.init(frame: CGRectMake(inview.frame.midX - 150, inview.frame.midY - 25 , 300, 50))
//        initalizeCustomIndicator()
//        
//    }
//    convenience init(inview:UIView) {
//        
//        self.init(inview: inview,loadingViewColor: UIColor.brownColor(),indicatorColor:UIColor.blackColor(), msg: "Loading..")
//    }
//    convenience init(inview:UIView,messsage:String) {
//        
//        self.init(inview: inview,loadingViewColor: UIColor.brownColor(),indicatorColor:UIColor.blackColor(), msg: messsage)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func initalizeCustomIndicator(){
//        
//        messageFrame.frame = self.bounds
//        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
//        activityIndicator.tintColor = indicatorColor
//        activityIndicator.hidesWhenStopped = true
//        activityIndicator.frame = CGRect(x: self.bounds.origin.x + 6, y: 0, width: 20, height: 50)
//        print(activityIndicator.frame)
//        let strLabel = UILabel(frame:CGRect(x: self.bounds.origin.x + 30, y: 0, width: self.bounds.width - (self.bounds.origin.x + 30) , height: 50))
//        strLabel.text = loadingMessage
//        strLabel.adjustsFontSizeToFitWidth = true
//        strLabel.textColor = UIColor.whiteColor()
//        messageFrame.layer.cornerRadius = 15
//        messageFrame.backgroundColor = loadingViewColor
//        messageFrame.alpha = 0.8
//        messageFrame.addSubview(activityIndicator)
//        messageFrame.addSubview(strLabel)
//        
//        
//    }
//    
//    func  start(){
//        //check if view is already there or not..if again started
//        if !self.subviews.contains(messageFrame){
//            
//            activityIndicator.startAnimating()
//            self.addSubview(messageFrame)
//            
//        }
//    }
//    
//    func stop(){
//        
//        if self.subviews.contains(messageFrame){
//            
//            activityIndicator.stopAnimating()
//            messageFrame.removeFromSuperview()
//            
//        }
//    }
//}
//

/* ADD TO VC.SWIFT
 
 var indicator:ProgressIndicator?
 override func viewDidLoad() {
 super.viewDidLoad()
 
 //indicator = ProgressIndicator(inview: self.view,messsage: "Hello from Nepal..")
 //self.view.addSubview(indicator!)
 //OR
 indicator = ProgressIndicator(inview:self.view,loadingViewColor: UIColor.grayColor(), indicatorColor: UIColor.blackColor(), msg: "Landing within minutes,Please hold tight..")
 self.view.addSubview(indicator!)
 
 }
 
 @IBAction func startBtn(sender: AnyObject) {
 indicator!.start()
 }
 
 
 @IBAction func stopBtn(sender: AnyObject) {
 indicator!.stop()
 }
 
 
 */
