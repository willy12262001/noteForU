//
//  UsersManager.swift
//  Project
//
//  Created by Willy on 2017/9/26.
//  Copyright © 2017年 Willy. All rights reserved.
//

import Foundation

class InfoManager:CoreDataManager<Info> {
    
    private(set) var infoItem:Info?
    
    static private(set) var shared:InfoManager?
    
    class func setAsSingleton(instance:InfoManager){
        shared = instance
    }
    
    func giveValue(toInfoItem:Info) {
        infoItem = toInfoItem
    }
    
    
    //MARK: - EditUsers & Create
    func extractedFunc() {
        editInfo(originalItem: nil) { (success, item) in
            
            guard success == true else {
                return
            }
            do{
                try usersDataManager.userItem?.managedObjectContext?.save()
            } catch {
                print("Error : can't save for the paperVC")
            }
            
        }
    }
    typealias EditDoneHandler = (_ success:Bool,_ resultItem:Info?) -> Void
    
    func editInfo(originalItem:Info?,completion:@escaping EditDoneHandler) {
        var finalItem = originalItem
        if finalItem == nil {
            finalItem = infoDataManager?.createItemTo(target: usersDataManager.userItem!)
            usersDataManager.userItem?.addToInfo(finalItem!)
            finalItem?.date = NSDate() as Date
        }
        //轉成DATA檔案
        let dataColor = NSKeyedArchiver.archivedData(withRootObject: color)
        let dataColorL = NSKeyedArchiver.archivedData(withRootObject: colorL)
        finalItem?.color = dataColor
        finalItem?.colorL = dataColorL
        
        if let attStr = attString {
            let x = NSKeyedArchiver.archivedData(withRootObject: attStr)
            finalItem?.attStr = x
        }
        if let contentt = content {
            finalItem?.content = contentt
        }
        if let date = currentDate {
            finalItem?.dateString = date
        }
        completion(true,finalItem)
    }
    //下載後的存取
    func editInfoForDownload(originalItem:Info?,completion:@escaping EditDoneHandler) {
        var finalItem = originalItem
        if finalItem == nil {
            finalItem = infoDataManager?.createItemTo(target: usersDataManager.userItem!)
            usersDataManager.userItem?.addToInfo(finalItem!)
            
            finalItem?.date = NSDate() as Date
            
        }
        //string轉成DATA檔案
        let colorString = responseDict!["color"] as! String
        let colorData = Data(base64Encoded: colorString, options: .ignoreUnknownCharacters)
        finalItem?.color = colorData
        
        let colorLString = responseDict!["colorL"] as! String
        let colorLData = Data(base64Encoded: colorLString, options: .ignoreUnknownCharacters)
        finalItem?.colorL = colorLData
        
        let attString = responseDict!["attStr"] as! String
        let attData = Data(base64Encoded: attString, options: .ignoreUnknownCharacters)
        finalItem?.attStr = attData
        
        
        if let date = responseDict!["date"] {
            finalItem?.dateString = date as! String
        }
        completion(true,finalItem)
    }
    
}

