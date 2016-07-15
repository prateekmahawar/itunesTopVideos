//
//  SettingTVC.swift
//  itunesTopVideos
//
//  Created by Prateek Mahawar on 16/07/16.
//  Copyright © 2016 Prateek Mahawar. All rights reserved.
//

import UIKit

class SettingTVC: UITableViewController {

    @IBOutlet weak var aboutDisplay: UILabel!
    @IBOutlet weak var feedbackDisplay: UILabel!
    @IBOutlet weak var securityDisplay: UILabel!
    @IBOutlet weak var bestImageDisplay: UILabel!
    @IBOutlet weak var touchId: UISwitch!
    @IBOutlet weak var apiCount: UILabel!
    @IBOutlet weak var sliderCnt: UISlider!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        tableView.alwaysBounceVertical = false
        
        
        touchId.on = NSUserDefaults.standardUserDefaults().boolForKey("SecSetting")
        if (NSUserDefaults.standardUserDefaults().objectForKey("APICNT") != nil)
        {
            let theValue = NSUserDefaults.standardUserDefaults().objectForKey("APICNT") as! Int
            apiCount.text = "\(theValue)"
            sliderCnt.value = Float(theValue)
        }

    }
    
    @IBAction func sliderChanged(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(Int(sliderCnt.value), forKey: "APICNT")
        apiCount.text = ("\(Int(sliderCnt.value))")
    }
    @IBAction func touchIDSec(sender: UISwitch) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if touchId.on {
            defaults.setBool(touchId.on, forKey: "SecSetting")
        } else {
            defaults.setBool(false, forKey: "SecSetting")
        }
        
    }

    
}
