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
    var imagesArray = [Any]()
    
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
        //從NSData轉成我指定的屬性
        if let x = infoDataManager?.infoItem?.attStr {
            //從Data檔案轉回NSAttributedString
            let unarchiveAttStr = NSKeyedUnarchiver.unarchiveObject(with: x) as! NSAttributedString
            //從NSAttributedString取回裡面的附件
            unarchiveAttStr.enumerateAttribute(NSAttributedStringKey.attachment, in: NSMakeRange(0, unarchiveAttStr.length), options: [], using: { (value, range, stop) in
                
                if value is NSTextAttachment {
                    let attachment: NSTextAttachment? = (value as? NSTextAttachment)
                    var image: UIImage? = nil
                    
                    if attachment?.image != nil {
                        
                        image = attachment?.image
                        let resizeIMG = resizeImgage(input: image!)
                        
                        attachment?.image = resizeIMG
                        attachment?.bounds = CGRect(x: 0, y: 0, width: resizeIMG.size.width * 0.45, height: resizeIMG.size.height * 0.45)
                    } else {
                        image = attachment?.image(forBounds: (attachment?.bounds)!, textContainer: nil, characterIndex: range.location)
                    }
                    if let image1 = image {
                        imagesArray.append(image1)
                    }
                }
            })
            textView.attributedText = unarchiveAttStr
        }
        //讀取 cell顏色
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
        //        content = textView.text
        print(imagesArray.count)
        attString = textView.attributedText
        content = textView.text
        
        infoDataManager?.editInfo(originalItem: infoDataManager?.infoItem, completion: { (success, item) in
            
            guard success == true else {
                return
            }
            do{
            try usersDataManager.userItem?.managedObjectContext?.save()
            } catch {
                print("Error: can't save for the displayVC")
            }
            
            self.dismiss(animated: true, completion: nil)
            
        })
        
    }
    
    @IBAction func deletePage(_ sender: Any) {
        guard let item = infoDataManager?.infoItem else {
            return
        }
        usersDataManager.userItem?.managedObjectContext?.delete(item)
        
        do{
            try usersDataManager.userItem?.managedObjectContext?.save()
        } catch {
            print("Error: can't save for the displayVC")
        }
        
        dismiss(animated: true, completion: nil)
    }
    //MARK: -  viewWillDisappear
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
