//
//  GlobalVariables.swift
//  noteForU
//
//  Created by Willy on 2017/10/3.
//  Copyright © 2017年 Willy. All rights reserved.
//

import Foundation

var gesture:GestureRecognizer?
var usersDataManager:UsersManager?
var infoDataManager:InfoManager?
//user專用
var uuid:String? = nil
var userName:String? = nil
var mail:String? = nil
var photoUrl:String? = nil
var CDpassword:String? = nil
//info專用
var colorRL = 0.8
var colorGL = 0.75
var colorBL = 0.53

var colorR = 0.98
var colorG = 1.0
var colorB = 0.58

var color = UIColor(red: 0.98, green: 1, blue: 0.58, alpha: 1)
var colorL = UIColor(red: 0.8, green: 0.75, blue: 0.53, alpha: 1)
var content:String? = nil
var photo:Data? = nil
var currentDate:String? = nil

