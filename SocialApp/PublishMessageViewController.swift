//
//  ShareMessageViewController.swift
//  SocialApp
//
//  Created by Sergey Kargopolov on 2016-09-04.
//  Copyright © 2016 Sergey Kargopolov. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKShareKit
import FBSDKLoginKit

class PublishMessageViewController: UIViewController {

    @IBOutlet weak var myTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.automaticallyAdjustsScrollViewInsets = false
        
        if !(FBSDKAccessToken.current().hasGranted("publish_actions")) {
 
            print("require publish_actions permissions")
            requestPublishPermissions()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func publishMessage()
    {
        let messageToPost = myTextView.text
        
        if (messageToPost?.isEmpty)! {
           return
        }
        
        FBSDKGraphRequest.init(graphPath: "me/feed", parameters: ["message" : messageToPost!], httpMethod: "POST").start(completionHandler: { (connection, result, error) -> Void in
            if let error = error {
                print("Error: \(error)")
            } else {
                print("Success")
                self.myTextView.text = ""
            }
        })

    }
    
    func requestPublishPermissions()
    {
        let login: FBSDKLoginManager = FBSDKLoginManager()
        
        login.logIn(withPublishPermissions: ["publish_actions"], from: self) { (result, error) in
            if (error != nil) {
                print(error!)
            } else if (result?.isCancelled)! {
                print("Canceled")
            } else if (result?.grantedPermissions.contains("publish_actions"))! {
                print("permissions granted")
            }
        }
    }
    
     @IBAction func sendButton(_ sender: AnyObject) {
        if FBSDKAccessToken.current().hasGranted("publish_actions") {
            publishMessage()
        }
    }
    

}
