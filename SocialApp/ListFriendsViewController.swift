//
//  ListFriendsViewController.swift
//  SocialApp
//
//  Created by Sergey Kargopolov on 2016-08-29.
//  Copyright © 2016 Sergey Kargopolov. All rights reserved.
//

import UIKit
import FBSDKCoreKit

class ListFriendsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let _ = FBSDKAccessToken.currentAccessToken()
        {
            fetchListOfFriends()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func fetchListOfFriends()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me/invitable_friends", parameters: ["fields":"uid,name"] )
        
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
                print("fetched user: \(result)")
                
            }
        })
    }


}
