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

class ShareVideoFromLibraryViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupImagePickerButton()
        if PHPhotoLibrary.authorizationStatus() != PHAuthorizationStatus.authorized {
            PHPhotoLibrary.requestAuthorization({ (status: PHAuthorizationStatus) in
                
            })
        }
        
    }
    
    func setupImagePickerButton()
    {
        let button = UIButton(type: UIButtonType.system) as UIButton
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        let buttonWidth:CGFloat = 150
        let buttonHeight:CGFloat = 45
        let xPostion:CGFloat = (screenWidth/2)-(buttonWidth/2)
        let yPostion:CGFloat = 70
        
        button.frame = CGRect(x: xPostion, y: yPostion, width: buttonWidth, height: buttonHeight)
        
        button.backgroundColor = UIColor.lightGray
        button.setTitle("Select video", for: UIControlState())
        button.tintColor = UIColor.black
        button.addTarget(self, action: #selector(ShareVideoFromLibraryViewController.displayImagePickerButtonTapped) , for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    func displayImagePickerButtonTapped() {
        
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum
        myPickerController.mediaTypes = [kUTTypeMovie as String]
        
        self.present(myPickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
 
        // Get Asset URL
        let videoUrl = info[UIImagePickerControllerReferenceURL] as? URL
    
        let facebookVideo = FBSDKShareVideo()
        facebookVideo.videoURL =  videoUrl
        
        let facebookShareVideoContent = FBSDKShareVideoContent()
        facebookShareVideoContent.video = facebookVideo
    
        let shareButton = FBSDKShareButton()
        shareButton.shareContent = facebookShareVideoContent
        shareButton.center = view.center
        
        // Add share FBSDKShareVideo to main view
        DispatchQueue.main.async {
          self.view.addSubview(shareButton)
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
