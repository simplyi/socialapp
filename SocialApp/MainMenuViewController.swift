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
        "User photos(Uploaded or tagged on)" //4
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
            
            
        default:
            break
            
        }
    }
}
