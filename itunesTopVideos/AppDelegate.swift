//
//  AppDelegate.swift
//  itunesTopVideos
//
//  Created by Prateek Mahawar on 12/07/16.
//  Copyright © 2016 Prateek Mahawar. All rights reserved.
//

import UIKit
var reachability : Reachability?
var reachabilitystatus = " "


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var internetCheck: Reachability?

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
      
//      NSURLCache.setSharedURLCache((NSURLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)))
        
      NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.reachabilityChanged(_:)), name: NSNotification.Name.reachabilityChanged, object: nil)
        
        internetCheck = Reachability.forInternetConnection()
        internetCheck?.startNotifier()
        statusChangedWithReachability(internetCheck!)
        
        return true
    }
    
    func reachabilityChanged(_ notification: Notification){
        reachability = notification.object as? Reachability
        statusChangedWithReachability(reachability!)
    }
    func statusChangedWithReachability(_ currentReachabilityStatus: Reachability){
        let networkStatus: NetworkStatus = currentReachabilityStatus.currentReachabilityStatus()
        switch networkStatus.rawValue {
        case NotReachable.rawValue : reachabilitystatus = NOACCESS
        case ReachableViaWiFi.rawValue : reachabilitystatus = WIFI
        case ReachableViaWWAN.rawValue : reachabilitystatus = WWAN
        default: return
        }
        NotificationCenter.default.post(name: Notification.Name(rawValue: "ReachStatusChanged"), object: nil)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.reachabilityChanged, object: nil)
    }


}

