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

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let button = FBSDKLoginButton()
        button.center = view.center
        button.readPermissions = ["public_profile","email","user_friends"]
   
        self.view.addSubview(button)
    }
    
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

