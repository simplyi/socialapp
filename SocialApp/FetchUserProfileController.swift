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
        
        if let _ = FBSDKAccessToken.current()
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
        
        graphRequest.start(completionHandler: { (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                print("Error took place: \(error)")
            }
            else
            {
                print("Print entire fetched result: \(result)")
                
               // let id : NSString = result.value(forKey: "id") as! String
                let fbResult:[String:AnyObject] = result as! [String : AnyObject]
                print("User ID is: \(fbResult["id"])")
                
                if let userName = fbResult["name"] as? String
                {
                    self.userFullName.text = userName
                }
                
                if let profilePictureObj = fbResult["picture"] as? NSDictionary
                {
                    let data = profilePictureObj.value(forKey: "data") as! NSDictionary
                    let pictureUrlString  = data.value(forKey: "url") as! String
                    let pictureUrl = URL(string: pictureUrlString)
                    
                    DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async {
                        
                        let imageData = try? Data(contentsOf: pictureUrl!)
                        
                        DispatchQueue.main.async {
                            if let imageData = imageData
                            {
                                let userProfileImage = UIImage(data: imageData)
                                self.userProfileImage.image = userProfileImage
                                self.userProfileImage.contentMode = UIViewContentMode.scaleAspectFit
                            }
                        }
                    }
                }
            }
        })
    }
 
}
