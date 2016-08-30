//
//  LikeButtonViewController.swift
//  SocialApp
//
//  Created by Sergey Kargopolov on 2016-08-30.
//  Copyright © 2016 Sergey Kargopolov. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKShareKit

class LikeButtonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let likeButton = FBSDKLikeControl()
        likeButton.center = view.center
        likeButton.objectID = "https://www.facebook.com/FacebookDevelopers"
        
        self.view.addSubview(likeButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
