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
 
        let inviteButton = UIButton(type: UIButtonType.System) as UIButton
        let xPostion:CGFloat = 50
        let yPostion:CGFloat = 100
        let buttonWidth:CGFloat = 150
        let buttonHeight:CGFloat = 45
        
        inviteButton.frame = CGRectMake(xPostion, yPostion, buttonWidth, buttonHeight)
        inviteButton.setTitle("Invite Friends", forState: UIControlState.Normal)
        inviteButton.tintColor = UIColor.blackColor()
        inviteButton.addTarget(self, action: "inviteButtonTapped", forControlEvents: UIControlEvents.TouchUpInside)
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
            
            let appLinkUrl:NSURL = NSURL(string: "http://yourwebpage.com")!
            let previewImageUrl:NSURL = NSURL(string: "http://yourwebpage.com/preview-image.png")!
            
            let inviteContent:FBSDKAppInviteContent = FBSDKAppInviteContent()
            inviteContent.appLinkURL = appLinkUrl
            inviteContent.appInvitePreviewImageURL = previewImageUrl
            
            inviteDialog.content = inviteContent
            inviteDialog.delegate = self
            inviteDialog.show()
        }
    }

    
    func appInviteDialog(appInviteDialog: FBSDKAppInviteDialog!, didCompleteWithResults results: [NSObject : AnyObject]!) {
    
        let resultObject = NSDictionary(dictionary: results)
        
        if let didCancel = resultObject.valueForKey("completionGesture")
        {
            if didCancel.caseInsensitiveCompare("Cancel") == NSComparisonResult.OrderedSame
            {
                print("User Canceled invitation dialog")
            }
        }
  
    }
    
    func appInviteDialog(appInviteDialog: FBSDKAppInviteDialog!, didFailWithError error: NSError!) {
        print("Error tool place in appInviteDialog \(error)")
    }


}
