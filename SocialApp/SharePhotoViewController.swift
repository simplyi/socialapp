//
//  SharePhotoViewController.swift
//  SocialApp
//
//  Created by Sergey Kargopolov on 2016-09-02.
//  Copyright © 2016 Sergey Kargopolov. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKShareKit

class SharePhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    var myImageView: UIImageView!
    var showImagePicketButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupImagePickerButton()
        
        setupImageView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupImagePickerButton()
    {
        let button = UIButton(type: UIButtonType.System) as UIButton
        
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width
 
        let buttonWidth:CGFloat = 150
        let buttonHeight:CGFloat = 45
        let xPostion:CGFloat = (screenWidth/2)-(buttonWidth/2)
        let yPostion:CGFloat = 70
        
        button.frame = CGRectMake(xPostion, yPostion, buttonWidth, buttonHeight)
        
        button.backgroundColor = UIColor.lightGrayColor()
        button.setTitle("Select photo", forState: UIControlState.Normal)
        button.tintColor = UIColor.blackColor()
        button.addTarget(self, action: #selector(SharePhotoViewController.displayImagePickerButtonTapped) , forControlEvents: .TouchUpInside)
        self.view.addSubview(button)
    }
    
    func setupImageView()
    {
        myImageView = UIImageView()
        
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width
        
        let imageWidth:CGFloat = 200
        let imageHeight:CGFloat = 200
        
        let xPostion:CGFloat = (screenWidth/2) - (imageWidth/2)
        let yPostion:CGFloat = 100
        
        myImageView.frame = CGRectMake(xPostion, yPostion, imageWidth, imageHeight)
        
        self.view.addSubview(myImageView)
    }
    
    func displayImagePickerButtonTapped() {
        
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(myPickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        myImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        myImageView.backgroundColor = UIColor.clearColor()
        myImageView.contentMode = UIViewContentMode.ScaleAspectFit
        self.dismissViewControllerAnimated(true, completion: nil)
        
        let photo:FBSDKSharePhoto = FBSDKSharePhoto()
 
        photo.image = myImageView.image
        photo.userGenerated = true
        
        let content:FBSDKSharePhotoContent = FBSDKSharePhotoContent()
        content.photos = [photo]
        
        let shareButton = FBSDKShareButton()
        shareButton.center = view.center
        
        shareButton.shareContent = content
        
        shareButton.center = self.view.center
        self.view.addSubview(shareButton)
        
    }

}
