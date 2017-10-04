//
//  PaperViewController.swift
//  noteForU
//
//  Created by Willy on 2017/9/29.
//  Copyright © 2017年 Willy. All rights reserved.
//

import UIKit

class PaperViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
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
        //鍵盤上加toolbar
        addDoneButtonOnKeyboard(target: textView)
        //剛打開的背景顏色
        paperView.backgroundColor = color
        colorR = 0.98
        colorG = 1
        colorB = 0.58
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backToPage(_ sender: Any) {
        //創物件並存擋
        content = textView.text
        infoDataManager?.extractedFunc()
        
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
    
    //MARK: - Choose color BTN
    @IBAction func yellowBTN(_ sender: Any) {
        
        let yellow = UIColor(red: 0.98, green: 1, blue: 0.58, alpha: 1)
        paperView.backgroundColor = yellow
        
        colorR = 0.98
        colorG = 1
        colorB = 0.58
        
        color = yellow
        
    }
    @IBAction func orangeBTN(_ sender: Any) {
        
        let orange = UIColor(red: 0.99, green: 0.62, blue: 0.25, alpha: 1)
        paperView.backgroundColor = orange
        
        colorR = 0.99
        colorG = 0.62
        colorB = 0.25
        
        color = orange
        
    }
    @IBAction func pinkBTN(_ sender: Any) {
        
        let pink = UIColor(red: 0.99, green: 0.61, blue: 0.98, alpha: 1)
        paperView.backgroundColor = pink
        
        colorR = 0.99
        colorG = 0.61
        colorB = 0.98
        
        color = pink
        
    }
    @IBAction func greenBTN(_ sender: Any) {
        
        let green = UIColor(red: 0.59, green: 0.92, blue: 0.58, alpha: 1)
        paperView.backgroundColor = green
        
        colorR = 0.59
        colorG = 0.92
        colorB = 0.58
        
        color = green
        
    }
    @IBAction func blueBTN(_ sender: Any) {
        
        let blue = UIColor(red: 0.64, green: 1, blue: 0.95, alpha: 1)
        paperView.backgroundColor = blue
        
        colorR = 0.64
        colorG = 1
        colorB = 0.95
        
        color = blue
        
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
