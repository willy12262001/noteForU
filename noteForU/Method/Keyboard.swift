//
//  Keyboard.swift
//  noteForU
//
//  Created by Willy on 2017/10/3.
//  Copyright © 2017年 Willy. All rights reserved.
//

import Foundation

extension PaperViewController {
    
    func addDoneButtonOnKeyboard(target:UITextView) {
        
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle   = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        //文字按鈕
        let doneBtn: UIBarButtonItem  = UIBarButtonItem(image: UIImage(named: "keyboard.png"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(doneButtonAction))
        
        //圖片按鈕
        let imgBtn: UIBarButtonItem  = UIBarButtonItem(image: UIImage(named: "photo.png"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(imgButtonAction))
        
        
        var items = [UIBarButtonItem]()
        items.append(imgBtn) //左邊按鈕
        items.append(flexSpace)
        items.append(doneBtn) //右邊按鈕
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        //指定哪個 text 欄位
        target.inputAccessoryView = doneToolbar
        
    }
    
    @objc private func imgButtonAction() {
        
        let alert = UIAlertController(title: "添加新照片", message: nil, preferredStyle: .actionSheet
        )
        
        let camera = UIAlertAction(title: "拍照", style: .default) { (_) in
            self.launchImagePicker(sourceType: .camera)
        }
        let photo = UIAlertAction(title: "相簿", style: .default) { (_) in
            self.launchImagePicker(sourceType: .photoLibrary)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(camera)
        alert.addAction(photo)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func doneButtonAction() {
        self.textView.endEditing(true)
    }
    //MARK: - Methods
    //ChoosePhoto
    func launchImagePicker(sourceType: UIImagePickerControllerSourceType) {
        // 檢查硬體設備是否相同 sourceType
        if UIImagePickerController.isSourceTypeAvailable(sourceType) == false {
            NSLog("No Available Device")
            return
        }
        // Prepare UIImagePicker
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.mediaTypes = ["public.image","public.movie"]
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        let photoImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        //把圖片設定成附件
        let attachment = NSTextAttachment()
        //resize photo
        let image = resizeImgage(input: photoImage)
        attachment.image = image
        attachment.bounds = CGRect(x: 0 , y: 0, width: image.size.width * 0.4 , height: image.size.height * 0.4)
        //轉換成可變本文
        let attStr = NSAttributedString(attachment: attachment)
        //獲取textView的所有文本
        let mutableStr = NSMutableAttributedString(attributedString: textView.attributedText)
        let selectedRange = textView.selectedRange
        //插入
        mutableStr.insert(attStr, at: selectedRange.location)
        
        mutableStr.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 20), range: NSMakeRange(0,mutableStr.length))
//        let newSelectedRange = NSMakeRange(selectedRange.location + 1, 0)
//        textView.selectedRange = newSelectedRange
        textView.attributedText = mutableStr
        attString = mutableStr
    }
    
}



