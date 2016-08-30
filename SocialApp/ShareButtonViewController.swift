//
//  ShareButtonViewController.swift
//  SocialApp
//
//  Created by Sergey Kargopolov on 2016-08-30.
//  Copyright © 2016 Sergey Kargopolov. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKShareKit

class ShareButtonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let shareContent = FBSDKShareLinkContent()
        shareContent.contentURL = NSURL(string: "https://www.facebook.com/FacebookDevelopers")

        let shareButton = FBSDKShareButton()
        shareButton.center = view.center
        
        shareButton.shareContent = shareContent
 
        self.view.addSubview(shareButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 

}
