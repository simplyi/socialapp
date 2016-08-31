//
//  FetchUserProfileController.swift
//  SocialApp
//
//  Created by Sergey Kargopolov on 2016-08-29.
//  Copyright © 2016 Sergey Kargopolov. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class FetchUserProfileController: UIViewController {
    
    @IBOutlet weak var userFullName: UILabel!
    @IBOutlet weak var userProfileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userFullName.text = ""
        
        if let _ = FBSDKAccessToken.currentAccessToken()
        {
            fetchUserProfile()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func fetchUserProfile()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"id, email, name, picture.width(480).height(480)"])
        
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                print("Error took place: \(error)")
            }
            else
            {
                print("Print entire fetched result: \(result)")
                
                let id : NSString = result.valueForKey("id") as! String
                print("User ID is: \(id)")
                
                if let userName = result.valueForKey("name") as? String
                {
                    self.userFullName.text = userName
                }
                
                if let profilePictureObj = result.valueForKey("picture") as? NSDictionary
                {
                    let data = profilePictureObj.valueForKey("data") as! NSDictionary
                    let pictureUrlString  = data.valueForKey("url") as! String
                    let pictureUrl = NSURL(string: pictureUrlString)
                    
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                        
                        let imageData = NSData(contentsOfURL: pictureUrl!)
                        
                        dispatch_async(dispatch_get_main_queue()) {
                            if let imageData = imageData
                            {
                                let userProfileImage = UIImage(data: imageData)
                                self.userProfileImage.image = userProfileImage
                                self.userProfileImage.contentMode = UIViewContentMode.ScaleAspectFit
                            }
                        }
                    }
                }
            }
        })
    }
 
}
