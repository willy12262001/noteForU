//
//  PaperViewController.swift
//  noteForU
//
//  Created by Willy on 2017/9/29.
//  Copyright © 2017年 Willy. All rights reserved.
//

import UIKit

class PaperViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate ,UITextViewDelegate{
    //身體顏色
    @IBOutlet weak var paperView: UIView!
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var dateLabel: UILabel!
    //title顏色
    @IBOutlet weak var head: UIView!
    //選色
    @IBOutlet weak var containerOfcolorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //畫面圓角
        paperView.clipsToBounds = true
        head.clipsToBounds = true
        paperView.layer.cornerRadius = 10
        //隱藏色碼
        containerOfcolorView.isHidden = true
        //鍵盤加上Bariten
        addDoneButtonOnKeyboard(target: textView)
        //
        self.textView.delegate = self
        //添加觀察者
        self.view.addKeyboardNotification()
        
    }
    
    deinit{
        self.view.removeKeyboardNotification()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backToPage(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deletePage(_ sender: Any) {
        
    }
    
    
    @IBAction func chooseColore(_ sender: Any) {
        
        switch containerOfcolorView.isHidden {
        case true:
            containerOfcolorView.isHidden = false
        default:
            containerOfcolorView.isHidden = true
        }
    }
    
    
    @IBAction func yellowBTN(_ sender: Any) {
    }
    @IBAction func orangeBTN(_ sender: Any) {
    }
    @IBAction func pinkBTN(_ sender: Any) {
    }
    @IBAction func greenBTN(_ sender: Any) {
    }
    @IBAction func blueBTN(_ sender: Any) {
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        let select = textView.selectedRange
        print(select.location)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
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
