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
        let button = UIButton(type: UIButtonType.system) as UIButton
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
 
        let buttonWidth:CGFloat = 150
        let buttonHeight:CGFloat = 45
        let xPostion:CGFloat = (screenWidth/2)-(buttonWidth/2)
        let yPostion:CGFloat = 70
        
        button.frame = CGRect(x: xPostion, y: yPostion, width: buttonWidth, height: buttonHeight)
        
        button.backgroundColor = UIColor.lightGray
        button.setTitle("Select photo", for: UIControlState())
        button.tintColor = UIColor.black
        button.addTarget(self, action: #selector(SharePhotoViewController.displayImagePickerButtonTapped) , for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    func setupImageView()
    {
        myImageView = UIImageView()
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        let imageWidth:CGFloat = 200
        let imageHeight:CGFloat = 200
        
        let xPostion:CGFloat = (screenWidth/2) - (imageWidth/2)
        let yPostion:CGFloat = 100
        
        myImageView.frame = CGRect(x: xPostion, y: yPostion, width: imageWidth, height: imageHeight)
        
        self.view.addSubview(myImageView)
    }
    
    func displayImagePickerButtonTapped() {
        
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(myPickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        myImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        myImageView.backgroundColor = UIColor.clear
        myImageView.contentMode = UIViewContentMode.scaleAspectFit
        self.dismiss(animated: true, completion: nil)
        
        let photo:FBSDKSharePhoto = FBSDKSharePhoto()
 
        photo.image = myImageView.image
        photo.isUserGenerated = true
        
        let content:FBSDKSharePhotoContent = FBSDKSharePhotoContent()
        content.photos = [photo]
        
        let shareButton = FBSDKShareButton()
        shareButton.center = view.center
        
        shareButton.shareContent = content
        
        shareButton.center = self.view.center
        self.view.addSubview(shareButton)
        
    }

}
