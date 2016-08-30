//
//  ViewController.swift
//  SocialApp
//
//  Created by Sergey Kargopolov on 2016-08-26.
//  Copyright © 2016 Sergey Kargopolov. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let button = FBSDKLoginButton()
        button.center = view.center
        button.readPermissions = ["public_profile","email","user_friends","user_photos"]
        button.delegate = self
        self.view.addSubview(button)

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!)
    {
        if(error != nil)
        {
            print(error.localizedDescription)
            return
        }
        
        if let userToken = result.token
        {
            //Get user access token
            print("User token \(userToken.tokenString)")
            print("User ID = \(FBSDKAccessToken.currentAccessToken().userID)")
            //print("Token: \(FBSDKAccessToken.currentAccessToken().tokenString)")
   
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!)
    {
    }
    
       
    
}

