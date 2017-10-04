//
//  TableViewController.swift
//  noteForU
//
//  Created by Willy on 2017/9/28.
//  Copyright © 2017年 Willy. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {

    @IBOutlet weak var menuBTN: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        gesture?.turnOnMenu(target: menuBTN, VCtarget: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addItem(_ sender: Any) {
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
