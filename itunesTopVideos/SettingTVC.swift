//
//  SettingTVC.swift
//  itunesTopVideos
//
//  Created by Prateek Mahawar on 16/07/16.
//  Copyright © 2016 Prateek Mahawar. All rights reserved.
//

import UIKit
import MessageUI

class SettingTVC: UITableViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var aboutDisplay: UILabel!
    @IBOutlet weak var feedbackDisplay: UILabel!
    @IBOutlet weak var securityDisplay: UILabel!
    @IBOutlet weak var bestImageDisplay: UILabel!
    @IBOutlet weak var touchId: UISwitch!
    @IBOutlet weak var apiCount: UILabel!
    @IBOutlet weak var sliderCnt: UISlider!
    let modelName = UIDevice.currentDevice().modelName
    
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
        } else {
            sliderCnt.value = 10.0
            apiCount.text = ("\(Int(sliderCnt.value))")
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

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 1{
            let mailComposeViewController = configureMail()
            if MFMailComposeViewController.canSendMail() {
                self.presentViewController(mailComposeViewController, animated: true, completion: nil)
            } else {
                mailAlert()
            }
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    
    func configureMail() -> MFMailComposeViewController {
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setToRecipients(["admin@testingground.xyz"])
        mailComposeVC.setSubject("App Review")
        mailComposeVC.setMessageBody("Hi Prateek, \n\nI would like to share feedback...\n\n (Running on \(modelName))", isHTML: false)
        return mailComposeVC
    }
    func mailAlert() {
        let alertController: UIAlertController = UIAlertController(title: "Alert", message: "No e-Mail Account Set", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default) {
            action -> Void in
            //ADD ACTION
        }
        alertController.addAction(okAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        switch result.rawValue{
        case MFMailComposeResultCancelled.rawValue:
            print("Mail Cancelled")
        case MFMailComposeResultSaved.rawValue:
            print("Mail Saved")
        case MFMailComposeResultSent.rawValue:
            print("Mail Send")
        case MFMailComposeResultFailed.rawValue:
            print("Mail Failed")
        default:
            print("Unknown Issue")
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
