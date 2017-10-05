//
//  DisplayPaperViewController.swift
//  noteForU
//
//  Created by Willy on 2017/10/5.
//  Copyright © 2017年 Willy. All rights reserved.
//

import UIKit

class DisplayPaperViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    //head顏色
    @IBOutlet weak var head: UIView!

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var bodyColor: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //畫面圓角
        bodyColor.clipsToBounds = true
        head.clipsToBounds = true
        bodyColor.layer.cornerRadius = 10
        //鍵盤上加toolbar
        addDoneButtonOnKeyboard(target: textView)
        
        //讀取coreData資料
        dateLabel.text = infoDataManager?.infoItem?.dateString
        textView.text = infoDataManager?.infoItem?.content
        //從NSData轉成我指定的屬性
        if let x = infoDataManager?.infoItem?.attStr {
            let unarchiveAttStr = NSKeyedUnarchiver.unarchiveObject(with: x)
            
                textView.attributedText = unarchiveAttStr as! NSAttributedString
        }
        //設定 cell顏色
        let unarchiveColor = NSKeyedUnarchiver.unarchiveObject(with: (infoDataManager?.infoItem?.color)!)
        let unarchiveColorL = NSKeyedUnarchiver.unarchiveObject(with: (infoDataManager?.infoItem?.colorL)!)
        bodyColor.backgroundColor = unarchiveColor as? UIColor
        head.backgroundColor = unarchiveColorL as? UIColor
        
        //讓全域變數都改成自己
        color = unarchiveColor as! UIColor
        colorL = unarchiveColorL as! UIColor
        currentDate = infoDataManager?.infoItem?.dateString
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: - BTN
    @IBAction func backTo(_ sender: Any) {
        content = textView.text
        attString = textView.attributedText
        
        infoDataManager?.editInfo(originalItem: infoDataManager?.infoItem, completion: { (success, item) in
            
            guard success == true else {
                return
            }
            
            infoDataManager?.saveContext() { (success) in
                
                if success {
                    NSLog("==========sucess save==========")
                } else {
                    NSLog("Save Fail")
                }
            }
            self.dismiss(animated: true, completion: nil)
            
        })
        
    }
   
    @IBAction func deletePage(_ sender: Any) {
        guard let item = infoDataManager?.infoItem else {
            return
        }
        infoDataManager?.delete(item: item)
        infoDataManager?.saveContext() { (success) in
            
            if success {
                NSLog("==========sucess save==========")
            } else {
                NSLog("Save Fail")
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.post(name:NSNotification.Name(rawValue: "NoteUUU"), object: nil)
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
