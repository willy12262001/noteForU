//
//  UINavigationBar+Transparent.swift
//  FirebaseDemo
//
//  Created by Simon Ng on 5/1/2017.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        // 將NavigationBar改成透明，並設定title的字型、字體大小及顏色
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        self.navigationBar.tintColor = UIColor.blue
//        self.navigationBar.setBackgroundImage(UIImage(named: "01.jpg"), for: UIBarMetrics.default)
        self.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Avenir", size: 24)!, NSAttributedStringKey.foregroundColor: UIColor.blue]
        
    }
}

extension AppDelegate {
    
    // Print出系統所有的字體，再將系統字體的確切名稱填入UIFont的methods內
    func printAllSystemFonts() {
        for family in UIFont.familyNames {
            print("Your system fonts: \(family)")
        }
    }
    
    // 替換BarButtonItem的字型、字體大小及顏色
    func customizeUIStyle() {
        // Customize Navigation bar items.
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "Avenir", size: 16)!, NSAttributedStringKey.foregroundColor: UIColor.blue], for: UIControlState.normal)
    }
}
