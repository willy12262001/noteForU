//
//  UsersManager.swift
//  Project
//
//  Created by Willy on 2017/9/26.
//  Copyright © 2017年 Willy. All rights reserved.
//

import Foundation

class UsersManager:CoreDataManager<Users> {
    
    private(set) var userItem:Users?
    
    static private(set) var shared:UsersManager?
    
    class func setAsSingleton(instance:UsersManager){
        shared = instance
    }
    
    func giveValue(toUserItem:Users) {
        userItem = toUserItem
    }
    
    //MARK: - Determine
    func createOrLogin() {
        //判斷是否有FB or Google資料在coredate裡
        if let result = usersDataManager?.searchBy(keyword: uuid!, field: "uuid"){
            
            guard result != [] else {
                //沒帳號的話創造
                extractedFunc()
                return
            }
            //LogIn
            for item in result {
                
//                NSLog("uuid: \(item.uuid ?? "無此帳號")")
                
                guard uuid == item.uuid else {
                    return
                }
                usersDataManager?.giveValue(toUserItem: item)
            }
        }
    }
    
    //MARK: - EditUsers & Create
    func extractedFunc() {
        editUser(originalItem: nil) { (success, item) in
            
            guard success == true else {
                return
            }
            
            usersDataManager?.giveValue(toUserItem: item!)
            
            usersDataManager?.saveContext(completion: { (success) in
                
                if success {
                    NSLog("==========sucess save==========")
                } else {
                    NSLog("Save Fail")
                }
                
            })
        }
    }
    typealias EditDoneHandler = (_ success:Bool,_ resultItem:Users?) -> Void
    
    func editUser(originalItem:Users?,completion:@escaping EditDoneHandler) {
        var finalItem = originalItem
        if finalItem == nil {
            finalItem = usersDataManager?.createItem()
            finalItem?.date = NSDate() as Date
        }
        if let uid = uuid{
            finalItem?.uuid = uid
        }
        
        if let name = userName {
            finalItem?.name = name
        }
        
        if let mail = mail {
            finalItem?.email = mail
        }
        
        if let photoUrl1 = photoUrl {
            finalItem?.photo = photoUrl1
        }
        if let password = CDpassword {
            finalItem?.password = password
        }
        completion(true,finalItem)
    }
    
}
