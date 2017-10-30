//
//  SignInViewController.swift
//  noteForU
//
//  Created by Willy on 2017/10/16.
//  Copyright © 2017年 Willy. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn

class SignInViewController: UIViewController,GIDSignInUIDelegate,GIDSignInDelegate {

    let alert = AlertSetting()
    
    let fbReadPermission = ["public_profile", "email", "user_friends"]
    
    @IBOutlet weak var logInLabel: UILabel!
    @IBOutlet weak var logInActiveView: UIActivityIndicatorView!
    @IBOutlet weak var fakeView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        //關閉轉圈圈
        fakeView.isHidden = true
        logInLabel.isHidden = true
        logInActiveView.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: - FB/GoogleSignIn
    @IBAction func fbSignIn(_ sender: Any) {
        //登入fb
        FBSDKLoginManager().logIn(withReadPermissions: fbReadPermission, from: self) { [weak self](result, error) in
            
            if error != nil{
                
                self?.alert.setting(target: self!, title: "Error", message: error?.localizedDescription, BTNtitle: "OK")
                
                print(error!)
                
                return
                
            } else {
                //打開登入中的頁面顯示
                self?.fakeView.isHidden = false
                self?.logInActiveView.startAnimating()
                self?.logInLabel.isHidden = false
                
                //確定登入fb後，用戶資料再用來登入firebase
                firebaseWorks.signInFireBaseWithFB(completion: {
                    [weak self](success) in
                    
                    if success == Result.success {
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                        
                        self?.logInActiveView.stopAnimating()
                        self?.logInLabel.isHidden = true
                        DispatchQueue.main.async {
                            self?.fakeView.isHidden = true
                        }
                        guestLoginBool = false
                        self?.present(vc, animated: true, completion: nil)
                        
                        
                    }
                })
            }
        }
    }
    //google SignIn
    @IBAction func googleSignIn(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error {
            print(error.localizedDescription)
            return
        }
        //打開登入中的頁面顯示
        self.fakeView.isHidden = false
        self.logInActiveView.startAnimating()
        self.logInLabel.isHidden = false
        
        //確定登入google後，用戶資料再用來登入firebase
        firebaseWorks.signInFireBaseWithGoogle(user: user) { [weak self](result) in
            
            if result == Result.success{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                
                self?.logInActiveView.stopAnimating()
                self?.logInLabel.isHidden = true
                DispatchQueue.main.async {
                    self?.fakeView.isHidden = true
                }
                guestLoginBool = false
                self?.present(vc, animated: true, completion: nil)
                
            }
        }
    }
    
    @IBAction func guestLogin(_ sender: Any) {
        alert.settingWithAct2(target: self, title: "警告", message: "使用訪客登入時，無法使用雲端上傳與下載功能", BTNtitle: "ok")
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
