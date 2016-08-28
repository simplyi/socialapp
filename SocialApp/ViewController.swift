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
        button.readPermissions = ["public_profile","email","user_friends"]
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
            
            fetchUserProfile()
            
            
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!)
    {
    }
    
    func fetchUserProfile()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"id,interested_in,gender,birthday,email,age_range,name,picture.width(480).height(480)"])
        
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
                print("fetched user: \(result)")
                let id : NSString = result.valueForKey("id") as! String
                print("User ID is: \(id)")
                
            }
        })
    }
    
    
}

