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
        editUser(originalItem: nil) { (success, item) in
            
            guard success == true else {
                return
            }
            
            infoDataManager?.saveContext(completion: { (success) in
                
                if success {
                    NSLog("==========sucess save==========")
                } else {
                    NSLog("Save Fail")
                }
                
            })
        }
    }
    typealias EditDoneHandler = (_ success:Bool,_ resultItem:Info?) -> Void
    
    func editUser(originalItem:Info?,completion:@escaping EditDoneHandler) {
        var finalItem = originalItem
        if finalItem == nil {
            finalItem = infoDataManager?.createItem()
            finalItem?.date = NSDate() as Date
        }
        if let colorb = colorB{
            finalItem?.colorB = colorb
        }
        
        if let colorr = colorR {
            finalItem?.colorR = colorr
        }
        
        if let colorg = colorG {
            finalItem?.colorG = colorg
        }
        if let contentt = content {
            finalItem?.content = contentt
        }
        completion(true,finalItem)
    }
    
}

