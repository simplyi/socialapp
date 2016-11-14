//
//  InviteFriendsViewController.swift
//  SocialApp
//
//  Created by Sergey Kargopolov on 2016-08-29.
//  Copyright © 2016 Sergey Kargopolov. All rights reserved.
//

import UIKit

import FBSDKCoreKit
import FBSDKShareKit

class InviteFriendsViewController: UIViewController, FBSDKAppInviteDialogDelegate {


    override func viewDidLoad() {
        super.viewDidLoad()
 
        let inviteButton = UIButton(type: UIButtonType.system) as UIButton
        let xPostion:CGFloat = 50
        let yPostion:CGFloat = 100
        let buttonWidth:CGFloat = 150
        let buttonHeight:CGFloat = 45
        
        inviteButton.frame = CGRect(x: xPostion, y: yPostion, width: buttonWidth, height: buttonHeight)
        inviteButton.setTitle("Invite Friends", for: UIControlState())
        inviteButton.tintColor = UIColor.black
        inviteButton.addTarget(self, action: #selector(InviteFriendsViewController.inviteButtonTapped), for: UIControlEvents.touchUpInside)
        self.view.addSubview(inviteButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func inviteButtonTapped()
    {
        print("Invite button tapped")
        
        let inviteDialog:FBSDKAppInviteDialog = FBSDKAppInviteDialog()
        if(inviteDialog.canShow()){
            
            let appLinkUrl:URL = URL(string: "http://www.swiftdeveloperblog.com")! //http://yourwebpage.com
            let previewImageUrl:URL = URL(string: "http://swiftdeveloperblog.com/wp-content/uploads/2015/08/440950_a9a0_3.jpg")! // Preview image
            
            let inviteContent:FBSDKAppInviteContent = FBSDKAppInviteContent()
            inviteContent.appLinkURL = appLinkUrl
            inviteContent.appInvitePreviewImageURL = previewImageUrl
            
            inviteDialog.content = inviteContent
            inviteDialog.delegate = self
            inviteDialog.show()
        } else {
            print("Invite feature is not available")
        }
    }

    
    /*!
     @abstract Sent to the delegate when the app invite encounters an error.
     @param appInviteDialog The FBSDKAppInviteDialog that completed.
     @param error The error.
     */
    public func appInviteDialog(_ appInviteDialog: FBSDKAppInviteDialog!, didFailWithError error: Error!) {
       print("Error tool place in appInviteDialog \(error)")
    }

    
    func appInviteDialog(_ appInviteDialog: FBSDKAppInviteDialog!, didCompleteWithResults results: [AnyHashable: Any]!) {
    
        if results == nil {
            return
        }
        
        let resultObject = NSDictionary(dictionary: results)
        
        if let didCancel = resultObject.value(forKey: "completionGesture")
        {
            if (didCancel as AnyObject).caseInsensitiveCompare("Cancel") == ComparisonResult.orderedSame
            {
                print("User Canceled invitation dialog")
            }
        }
  
    }
    
 


}
