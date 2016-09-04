//
//  ShareVideoUrlViewController.swift
//  SocialApp
//
//  Created by Sergey Kargopolov on 2016-09-04.
//  Copyright © 2016 Sergey Kargopolov. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKShareKit
import MobileCoreServices
import AssetsLibrary
import Photos

class ShareVideoFromCameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupImagePickerButton()
        if PHPhotoLibrary.authorizationStatus() != PHAuthorizationStatus.Authorized {
            PHPhotoLibrary.requestAuthorization({ (status: PHAuthorizationStatus) in
                
            })
        }
        
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
        button.addTarget(self, action: #selector(ShareVideoFromLibraryViewController.displayImagePickerButtonTapped) , forControlEvents: .TouchUpInside)
        self.view.addSubview(button)
    }
    
    func displayImagePickerButtonTapped() {
        
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType = UIImagePickerControllerSourceType.Camera
        myPickerController.mediaTypes = [kUTTypeMovie as String]
        
        self.presentViewController(myPickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        if picker.sourceType == UIImagePickerControllerSourceType.Camera
        {
            let video = info[UIImagePickerControllerMediaURL] as? NSURL
            let assetsLibrary = ALAssetsLibrary()
            
            assetsLibrary.writeVideoAtPathToSavedPhotosAlbum(video!,
                                                             completionBlock: {(url: NSURL!, error: NSError!) in
                                                                
                                                                print(url)
                                                                
                                                                if let theError = error{
                                                                    print("Error happened while saving the video")
                                                                    print("The error is = \(theError)")
                                                                } else {
                                                                    print("no errors happened")
                                                                    let facebookVideo = FBSDKShareVideo()
                                                                    facebookVideo.videoURL =  url
                                                                    
                                                                    let facebookShareVideoContent = FBSDKShareVideoContent()
                                                                    facebookShareVideoContent.video = facebookVideo
                                                                    
                                                                    let shareButton = FBSDKShareButton()
                                                                    shareButton.shareContent = facebookShareVideoContent
                                                                    shareButton.center = self.view.center
                                                                    
                                                                    // Add share FBSDKShareVideo to main view
                                                                    dispatch_async(dispatch_get_main_queue()) {
                                                                        self.view.addSubview(shareButton)
                                                                    }
                                                                    self.dismissViewControllerAnimated(true, completion: nil)
                                                                    
                                                                }
                                                                
            })
            
            
            
            
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}