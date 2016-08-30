//
//  ListUserPhotosViewController.swift
//  SocialApp
//
//  Created by Sergey Kargopolov on 2016-08-30.
//  Copyright © 2016 Sergey Kargopolov. All rights reserved.
//

import UIKit
import FBSDKCoreKit

class ListUserPhotosViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var userPhotos:NSArray?
    var myCollectionView:UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up collection view
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 60, height: 60)
        
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        myCollectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        myCollectionView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(myCollectionView)
        
        
        if let _ = FBSDKAccessToken.currentAccessToken()
        {
            fetchListOfUserPhotos()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchListOfUserPhotos()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me/photos", parameters: ["fields":"picture"] )
        
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
                print("fetched user: \(result)")
                self.userPhotos = result.valueForKey("data") as! NSArray?
                
                self.myCollectionView.reloadData()
 
            }
        })
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        var returnValue = 0
        
        if let userPhotosObject = self.userPhotos
        {
            returnValue = userPhotosObject.count
        }
        
        return returnValue
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCellWithReuseIdentifier("MyCell", forIndexPath: indexPath)
        myCell.backgroundColor = UIColor.blackColor()
        
        let userPhotoObject = self.userPhotos![indexPath.row] as! NSDictionary
        let userPhotoUrlString = userPhotoObject.valueForKey("picture") as! String
        
        let imageUrl:NSURL = NSURL(string: userPhotoUrlString)!
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            
            let imageData:NSData = NSData(contentsOfURL: imageUrl)!
            let imageView = UIImageView(frame: CGRectMake(0, 0, myCell.frame.size.width, myCell.frame.size.height))
            dispatch_async(dispatch_get_main_queue()) {
                
                let image = UIImage(data: imageData)
                imageView.image = image
                imageView.contentMode = UIViewContentMode.ScaleAspectFit
                
                myCell.addSubview(imageView)
            }
        }
        
        return myCell
    }

}
