//
//  ListUserAlbumsViewController.swift
//  SocialApp
//
//  Created by Sergey Kargopolov on 2016-09-06.
//  Copyright © 2016 Sergey Kargopolov. All rights reserved.
//

import UIKit
import FBSDKCoreKit

class ListUserAlbumsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var userAlbums:NSArray?
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
        myCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        myCollectionView.backgroundColor = UIColor.white
        self.view.addSubview(myCollectionView)
        
        
        if let _ = FBSDKAccessToken.current()
        {
            fetchListOfUserAlbums()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        var returnValue = 0
        
        if let userAlbumsObject = self.userAlbums
        {
            returnValue = userAlbumsObject.count
        }
        
        return returnValue
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath)
        myCell.backgroundColor = UIColor.black
        
        let userAlbumObject = self.userAlbums![indexPath.row] as! NSDictionary
        let userAlbumPictureObject = userAlbumObject.value(forKey: "picture") as! NSDictionary
        let userAlbumPictureDataObject = userAlbumPictureObject.value(forKey: "data") as! NSDictionary
        let usetAlbumPictureUrlString = userAlbumPictureDataObject.value(forKey: "url") as! String
        
        let imageUrl:URL = URL(string: usetAlbumPictureUrlString)!
        
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async {
            
            let imageData:Data = try! Data(contentsOf: imageUrl)
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: myCell.frame.size.width, height: myCell.frame.size.height))
            DispatchQueue.main.async {
                
                let image = UIImage(data: imageData)
                imageView.image = image
                imageView.contentMode = UIViewContentMode.scaleAspectFit
                
                myCell.addSubview(imageView)
            }
        }
        
        return myCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let userAlbumObject = self.userAlbums![indexPath.row] as! NSDictionary
        let userAlbumPhotosViewController = self.storyboard?.instantiateViewController(withIdentifier: "ListAlbumPhotosViewController") as! ListAlbumPhotosViewController
        
        userAlbumPhotosViewController.albumObject = userAlbumObject
        
        self.navigationController?.pushViewController(userAlbumPhotosViewController, animated: true)
        
    }


    func fetchListOfUserAlbums()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me/albums", parameters: ["fields":"picture, name, privacy"] )
        
        graphRequest.start(completionHandler: { (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
                print("fetched user: \(result)")
               // self.userAlbums = result.value(forKey: "data") as! NSArray?
                
                let fbResult:[String:AnyObject] = result as! [String : AnyObject]
                self.userAlbums = fbResult["data"] as! NSArray?
                
                
                self.myCollectionView.reloadData()
                
            }
        })

    }

}
