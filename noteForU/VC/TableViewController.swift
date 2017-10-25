//
//  TableViewController.swift
//  noteForU
//
//  Created by Willy on 2017/9/28.
//  Copyright © 2017年 Willy. All rights reserved.
//

import UIKit

class TableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var menuBTN: UIBarButtonItem!
    
    @IBOutlet weak var tableVIew: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Open Menu
        gesture?.turnOnMenu(target: menuBTN, VCtarget: self)
        //設定cell高度
        tableVIew.rowHeight = 110
        //觀察者
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name:NSNotification.Name(rawValue:"NoteUUU"), object: nil)
    }
    //MARK: - Methods
    @objc func reloadTableView()  {
        tableVIew.reloadData()
    }
    //MARK: - AddBTN
    @IBAction func addItem(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PaperViewController") as! PaperViewController
        present(vc, animated: true, completion: nil)
    }
    //MARK: - tableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersDataManager.userItem?.info?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as! MyTableViewCell
        
        let info = usersDataManager.userItem?.info?.allObjects[indexPath.row] as! Info
        
            cell.dateLabel.text = info.dateString
            cell.contentLabel.text = info.content
            
            //設定 cell顏色
            let unarchiveColor = NSKeyedUnarchiver.unarchiveObject(with: info.color!)
            let unarchiveColorL = NSKeyedUnarchiver.unarchiveObject(with: info.colorL!)
            cell.bodyColor.backgroundColor = unarchiveColor as? UIColor
            cell.titleColor.backgroundColor = unarchiveColorL as? UIColor

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "DisplayPaperViewController") as! DisplayPaperViewController
        
        let info = usersDataManager.userItem?.info?.allObjects[indexPath.row] as! Info
        
        infoDataManager?.giveValue(toInfoItem: info)
    
        present(vc, animated: true, completion: nil)
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
