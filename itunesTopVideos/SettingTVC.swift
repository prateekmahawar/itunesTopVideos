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
    @IBOutlet weak var bestImageSlider: UISwitch!
    @IBOutlet weak var touchId: UISwitch!
    @IBOutlet weak var apiCount: UILabel!
    @IBOutlet weak var sliderCnt: UISlider!
    let modelName = UIDevice.current.modelName
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        tableView.alwaysBounceVertical = false
        
        
        bestImageSlider.isOn = UserDefaults.standard.bool(forKey: "BmsSetting")
        touchId.isOn = UserDefaults.standard.bool(forKey: "SecSetting")
        if (UserDefaults.standard.object(forKey: "APICNT") != nil)
        {
            
            let theValue = UserDefaults.standard.object(forKey: "APICNT") as! Int
            apiCount.text = "\(theValue)"
            sliderCnt.value = Float(theValue)
        } else {
            sliderCnt.value = 10.0
            apiCount.text = ("\(Int(sliderCnt.value))")
        }

    }
    @IBAction func bestImageSlider(_ sender: UISwitch) {
        let defaults = UserDefaults.standard
        if bestImageSlider.isOn {
            defaults.set(bestImageSlider.isOn, forKey: "BmsSetting")
        } else {
            defaults.set(false, forKey: "BmsSetting")
        }
    }
    
    @IBAction func sliderChanged(_ sender: AnyObject) {
        let defaults = UserDefaults.standard
        defaults.set(Int(sliderCnt.value), forKey: "APICNT")
        apiCount.text = ("\(Int(sliderCnt.value))")
    }
    @IBAction func touchIDSec(_ sender: UISwitch) {
        
        let defaults = UserDefaults.standard
        if touchId.isOn {
            defaults.set(touchId.isOn, forKey: "SecSetting")
        } else {
            defaults.set(false, forKey: "SecSetting")
        }
        
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1{
            let mailComposeViewController = configureMail()
            if MFMailComposeViewController.canSendMail() {
                self.present(mailComposeViewController, animated: true, completion: nil)
            } else {
                mailAlert()
            }
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    
    func configureMail() -> MFMailComposeViewController {
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setToRecipients(["admin@testingground.xyz"])
        mailComposeVC.setSubject("App Review")
        mailComposeVC.setMessageBody("Hi Prateek, \n\nI would like to share feedback...\n\n (Running on \(modelName) with iOS \(systemVersion))", isHTML: false)
        return mailComposeVC
    }
    func mailAlert() {
        let alertController: UIAlertController = UIAlertController(title: "Alert", message: "No e-Mail Account Set", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) {
            action -> Void in
            //ADD ACTION
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result.rawValue{
        case MFMailComposeResult.cancelled.rawValue:
            print("Mail Cancelled")
        case MFMailComposeResult.saved.rawValue:
            print("Mail Saved")
        case MFMailComposeResult.sent.rawValue:
            print("Mail Send")
        case MFMailComposeResult.failed.rawValue:
            print("Mail Failed")
        default:
            print("Unknown Issue")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}
