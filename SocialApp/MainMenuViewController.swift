//
//  MainMenuViewController.swift
//  SocialApp
//
//  Created by Sergey Kargopolov on 2016-08-29.
//  Copyright © 2016 Sergey Kargopolov. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var myTableView: UITableView!
    
    
    let menuOptions = [
        "Facebook login button", //0
        "Fetch user profile", //1
        "Invite friends", //2
        "List my friends(/invitable_friends)", //3
        "User photos(Uploaded or tagged on)", //4
        "Like button", //5
        "Share button", //6
        "Send button", //7
        "Share photo", //8 
        "Share video with URL", //9
        "Share message dialog", //10
        "List user albums", //11
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myTableView.delegate = self
        myTableView.dataSource = self
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return menuOptions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let tableCell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath)
        
        tableCell.textLabel?.text = menuOptions[indexPath.row]
        
        return tableCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        print("\(menuOptions[indexPath.row]) is selected")
        
        switch indexPath.row
        {
        case 0:
            let loginViewController = self.storyboard?.instantiateViewControllerWithIdentifier("FacebookLoginButton") as! ViewController
            self.navigationController?.pushViewController(loginViewController, animated: true)
                break
            
        case 1:
            let userProfile = self.storyboard?.instantiateViewControllerWithIdentifier("FetchUserProfileController") as! FetchUserProfileController
            self.navigationController?.pushViewController(userProfile, animated: true)
            break
            
        case 2:
            let inviteFriendsController = self.storyboard?.instantiateViewControllerWithIdentifier("InviteFriendsViewController") as! InviteFriendsViewController
            self.navigationController?.pushViewController(inviteFriendsController, animated: true)
               break
            
        case 3:
            let listFriendsController = self.storyboard?.instantiateViewControllerWithIdentifier("ListFriendsViewController") as! ListFriendsViewController
            self.navigationController?.pushViewController(listFriendsController, animated: true)
            break
            
        case 4:
            let listUserPhotos = self.storyboard?.instantiateViewControllerWithIdentifier("ListUserPhotosViewController") as! ListUserPhotosViewController
            self.navigationController?.pushViewController(listUserPhotos, animated: true)
            break
            
        case 5:
            let linkeButtonViewController = self.storyboard?.instantiateViewControllerWithIdentifier("LikeButtonViewController") as! LikeButtonViewController
            self.navigationController?.pushViewController(linkeButtonViewController, animated: true)
            break
        case 6:
            let shareButtonViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ShareButtonViewController") as! ShareButtonViewController
            self.navigationController?.pushViewController(shareButtonViewController, animated: true)
            break
            
        case 7:
            let sendButtonViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SendButtonViewController") as! SendButtonViewController
            self.navigationController?.pushViewController(sendButtonViewController, animated: true)
            break
            
        case 8:
            let sharePhotoButtonViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SharePhotoViewController") as! SharePhotoViewController
            self.navigationController?.pushViewController(sharePhotoButtonViewController, animated: true)
            break
            
        case 9:
            let shareVideoFromLibraryViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ShareVideoFromLibraryViewController") as! ShareVideoFromLibraryViewController
            self.navigationController?.pushViewController(shareVideoFromLibraryViewController, animated: true)
            break
            
        case 10:
            let publishMessageDialogViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PublishMessageViewController") as! PublishMessageViewController
            self.navigationController?.pushViewController(publishMessageDialogViewController, animated: true)
            break
            
        case 11:
            let listUserAlbumsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ListUserAlbumsViewController") as! ListUserAlbumsViewController
            self.navigationController?.pushViewController(listUserAlbumsViewController, animated: true)
            break
 
            

            
            
        default:
            break
            
        }
    }
}
