//
//  HiViewController.swift
//  noteForU
//
//  Created by Willy on 2017/9/29.
//  Copyright © 2017年 Willy. All rights reserved.
//

import UIKit

class HiViewController: UIViewController {

    @IBOutlet weak var textField: UITextView!
    @IBOutlet weak var hi: UIView!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("\(hi.frame.width)")
        print("\(hi.frame.height)")
        print("\(hi.frame.origin.x)")
        print("\(hi.frame.origin.y)")
        hi.isHidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func enter(_ sender: Any) {
        
        UIView.animate(withDuration: 2) {
            self.hi.isHidden = false
            self.hi.frame = CGRect(x: 0, y:20, width: self.view.frame.width , height: self.view.frame.height)
            self.hi.sizeToFit()
            
        }
        
    }
    
    @IBAction func out(_ sender: Any) {
        
        UIView.animate(withDuration: 0.1) {
            self.hi.frame = CGRect(x: 67, y: 436.5, width: 240, height: 128)
            self.hi.isHidden = true
        }
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
