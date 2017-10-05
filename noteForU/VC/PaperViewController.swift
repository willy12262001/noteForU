//
//  PaperViewController.swift
//  noteForU
//
//  Created by Willy on 2017/9/29.
//  Copyright © 2017年 Willy. All rights reserved.
//

import UIKit

class PaperViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate{
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
        textView.delegate = self
        //畫面圓角
        paperView.clipsToBounds = true
        head.clipsToBounds = true
        paperView.layer.cornerRadius = 10
        //隱藏色碼
        containerOfcolorView.isHidden = true
        //鍵盤上加toolbar
        addDoneButtonOnKeyboard(target: textView)
        //剛打開的背景顏色
        color = UIColor(red: 0.98, green: 1, blue: 0.58, alpha: 1)
        colorL = UIColor(red: 0.8, green: 0.75, blue: 0.53, alpha: 1)
        paperView.backgroundColor = color
        head.backgroundColor = colorL
        //顯示時間在dateLabel
        dateLabel.text = dateSetting()
        currentDate = dateSetting()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: - FuncBTN
    @IBAction func backToPage(_ sender: Any) {
        //創物件並存擋
        attString = textView.attributedText
        content = textView.text
        
        infoDataManager?.extractedFunc()
        
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func chooseColore(_ sender: Any) {
        
        switch containerOfcolorView.isHidden {
        case true:
            containerOfcolorView.isHidden = false
        default:
            containerOfcolorView.isHidden = true
        }
    }
    
    //MARK: - Choose color BTN
    @IBAction func yellowBTN(_ sender: Any) {
        
        let yellow = UIColor(red: 0.98, green: 1, blue: 0.58, alpha: 1)
        paperView.backgroundColor = yellow
        
        let headColor = UIColor(red: 0.8, green: 0.75, blue: 0.53, alpha: 1)
        head.backgroundColor = headColor
        
        color = yellow
        colorL = headColor
        
    }
    @IBAction func orangeBTN(_ sender: Any) {
        
        let orange = UIColor(red: 0.99, green: 0.62, blue: 0.25, alpha: 1)
        paperView.backgroundColor = orange
        
        let headColor = UIColor(red: 0.6, green: 0.38, blue: 0.2, alpha: 1)
        head.backgroundColor = headColor
        
        color = orange
        colorL = headColor
        
    }
    @IBAction func pinkBTN(_ sender: Any) {
        
        let pink = UIColor(red: 0.99, green: 0.61, blue: 0.98, alpha: 1)
        paperView.backgroundColor = pink
        
        let headColor = UIColor(red: 0.68, green: 0.42, blue: 0.68, alpha: 1)
        head.backgroundColor = headColor
        
        color = pink
        colorL = headColor
        
    }
    @IBAction func greenBTN(_ sender: Any) {
        
        let green = UIColor(red: 0.59, green: 0.92, blue: 0.58, alpha: 1)
        paperView.backgroundColor = green
        
        let headColor = UIColor(red: 0.34, green: 0.52, blue: 0.33, alpha: 1)
        head.backgroundColor = headColor
        
        color = green
        colorL = headColor
        
    }
    @IBAction func blueBTN(_ sender: Any) {
        
        let blue = UIColor(red: 0.64, green: 1, blue: 0.95, alpha: 1)
        paperView.backgroundColor = blue
        
        let headColor = UIColor(red: 0.49, green: 0.77, blue: 0.73, alpha: 1)
        head.backgroundColor = headColor
        
        color = blue
        colorL = headColor
        
    }
    //MARK: - Method
    func dateSetting() -> String{
        
        let currentDay = Date()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd_HH:mm"
        
        let customCurrentDay = formatter.string(from: currentDay)
        
        return customCurrentDay
    }
    //MARK: - NotificationCenter.default.post
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
