//
//  DetailVC.swift
//  itunesTopVideos
//
//  Created by Prateek Mahawar on 15/07/16.
//  Copyright © 2016 Prateek Mahawar. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import LocalAuthentication

class DetailVC: UIViewController {

    var videos:Videos!
    var securitySwitch:Bool = false
    
    var sec:Bool = false
    
    @IBOutlet weak var vName: UILabel!
    @IBOutlet weak var videoImg: UIImageView!
    @IBOutlet weak var vGenre: UILabel!
    @IBOutlet weak var vPrice: UILabel!
    @IBOutlet weak var vRights: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        title = videos.vArtist
        vName.text = videos.vName
        vPrice.text = videos.vPrice
        vRights.text = videos.vRights
        vGenre.text = videos.vGenre
        
        videoImg.image = UIImage(named: "1")
        videoImg.downloadImageFrom(link: videos.vImageUrl, contentMode: .scaleAspectFit)
        videoImg.layer.masksToBounds = true
        
    }
    @IBAction func socialMedia(_ sender: UIBarButtonItem) {
        securitySwitch = UserDefaults.standard.bool(forKey: "SecSetting")
        
        switch securitySwitch {
        case true:
            touchIdChk()
        default:
            ShareMedia()
        }
        
        
    }
    
    func touchIdChk(){
        // Create an alert
        let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.cancel, handler: nil))
        
        
        // Create the Local Authentication Context
        let context = LAContext()
        var touchIDError : NSError?
        let reasonString = "Touch-Id authentication is needed to share info on Social Media"
        
        
        // Check if we can access local device authentication
        if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error:&touchIDError) {
            // Check what the authentication response was
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: { (success, policyError) -> Void in
                if success {
                    // User authenticated using Local Device Authentication Successfully!
                    DispatchQueue.main.async { [unowned self] in
                        self.ShareMedia()
                    }
                } else {
                    
                    alert.title = "Unsuccessful!"
                    
                    switch LAError.Code(rawValue: policyError!._code)! {
                        
                    case .appCancel:
                        alert.message = "Authentication was cancelled by application"
                        
                    case .authenticationFailed:
                        alert.message = "The user failed to provide valid credentials"
                        
                    case .passcodeNotSet:
                        alert.message = "Passcode is not set on the device"
                        
                    case .systemCancel:
                        alert.message = "Authentication was cancelled by the system"
                        
                    case .touchIDLockout:
                        alert.message = "Too many failed attempts."
                        
                    case .userCancel:
                        alert.message = "You cancelled the request"
                        
                    case .userFallback:
                        alert.message = "Password not accepted, must use Touch-ID"
                        
                    default:
                        alert.message = "Unable to Authenticate!"
                        
                    }
                    
                    // Show the alert
                    DispatchQueue.main.async { [unowned self] in
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            })
        } else {
            // Unable to access local device authentication
            
            // Set the error title
            alert.title = "Error"
            
            // Set the error alert message with more information
            switch LAError.Code(rawValue: touchIDError!.code)! {
                
            case .touchIDNotEnrolled:
                alert.message = "Touch ID is not enrolled"
                
            case .touchIDNotAvailable:
                alert.message = "TouchID is not available on the device"
                
            case .passcodeNotSet:
                alert.message = "Passcode has not been set"
                
            case .invalidContext:
                alert.message = "The context is invalid"
                
            default:
                alert.message = "Local Authentication not available"
            }
            
            // Show the alert
            DispatchQueue.main.async { [unowned self] in
                self.present(alert, animated: true, completion: nil)
            }
        }

    }
    
    func ShareMedia(){
        let activity1 = "Check out this great VIDEO"
        let activity2 = ("\(videos.vName) by \(videos.vArtist)")
        let activity3 = "Watch it and tell me what you think"
        let activity4 = videos.vLinkToItunes
        let activity5 = "Shared by YOURS TRULY"
        
        
        let activityViewController : UIActivityViewController = UIActivityViewController(activityItems: [activity1,activity2,activity3,activity4,activity5], applicationActivities: nil)
        
        //activityViewController.excludedActivityTypes = [UIActivityTypeMail]
        /* TYPES {UIActivityTypePrint
         UIActivityTypeCopyToPasteboard
         UIActivityTypeAssignToContact
         UIActivityTypeSaveToCameraRoll
         UIActivityTypeAddToReadingList
         UIActivityTypeAirDrop
         UIActivityTypeMessage
         UIActivityTypeMail
         UIActivityTypePostToFacebook
         UIActivityTypePostToTwitter
         UIActivityTypePostToFlickr
         UIActivityTypePostToVimeo
         UIActivityTypePostToTencentWeibo
         UIActivityTypePostToWeibo
        
         */
        present(activityViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func playVideo(_ sender: UIBarButtonItem) {
        
        let url = URL(string: videos.vVideoUrl)!
        let player = AVPlayer(url: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController,animated:true) {
            playerViewController.player?.play()
        }
        
    }

}
