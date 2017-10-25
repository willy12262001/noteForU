//
//  ContainerViewController.swift
//  Project
//
//  Created by Willy on 2017/9/28.
//  Copyright © 2017年 Willy. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit
import GoogleSignIn

class ContainerViewController: UIViewController {

//    let backGround = Color()
    
    @IBOutlet weak var userNames: UILabel!
    @IBOutlet weak var userPhoto: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

//        backGround.colorSetting(target: self.view)
        // 顯示使用者名稱＆照片
        let name = usersDataManager.userItem?.name
        userNames.text = name
        if let userImgUserURLString = usersDataManager.userItem?.photo {
            let userImgURL = URL(string:userImgUserURLString)
            let userImgData = NSData(contentsOf: userImgURL! )
            let userImage = UIImage(data: userImgData! as Data)
            userPhoto.image = userImage
        } else {
            userPhoto.image = UIImage(named:"userDefaultImage.png")
        }
        userPhoto.layer.cornerRadius = 50
        userPhoto.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func 登出(_ sender: Any) {
        
        FBSDKLoginManager().logOut()
        GIDSignIn.sharedInstance().signOut()
        
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                
                self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
