//
//  SendButtonViewController.swift
//  SocialApp
//
//  Created by Sergey Kargopolov on 2016-09-01.
//  Copyright © 2016 Sergey Kargopolov. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKShareKit

class SendButtonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let sendContent = FBSDKShareLinkContent()
        sendContent.contentURL = URL(string: "https://www.swiftdeveloperblog.com/code-examples")
        sendContent.contentDescription = "Short and ready to use Swift Code examples"
        
        let sendButton = FBSDKSendButton()
        sendButton.center = view.center
        
        sendButton.shareContent = sendContent
        
        if sendButton.isHidden {
            print("No messager installed and send feature is not supported")
        } else {
            self.view.addSubview(sendButton)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 

}
