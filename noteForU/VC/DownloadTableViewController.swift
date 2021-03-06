//
//  DownloadTableViewController.swift
//  noteForU
//
//  Created by Willy on 2017/10/25.
//  Copyright © 2017年 Willy. All rights reserved.
//

import UIKit
import Firebase

class DownloadTableViewController: UITableViewController {
    
    var downloadData: [String:NSDictionary]?
    let alert = AlertSetting()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func reloadData() {
        
        let databaseRef = Database.database().reference().child("users").child(uuid!).child("record")
        databaseRef.observe(.value, with: { [weak self](snapshot) in
            if let downloadDict = snapshot.value as? [String:NSDictionary] {
                self?.downloadData = downloadDict
                self?.tableView!.reloadData()
                print(self?.downloadData?.count ?? 0)
            }
        })
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return downloadData?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell3", for: indexPath)
        if let dataDic = downloadData {
            var keyArray = Array(dataDic.keys)
            let dateString = keyArray[indexPath.row]
            cell.textLabel?.text = dateString
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //下載中通知視窗
        self.alert.displayActivityIndicator(target: self, title: "下載中\n")
        
        if let dataDict = downloadData {
            var keyArray = Array(dataDict.keys)
            //選定哪個data
            let dataURL = dataDict[keyArray[indexPath.row]]!["data"] as! String
            
            if let downloadUrl = URL(string: dataURL) {
                URLSession.shared.dataTask(with: downloadUrl, completionHandler: { [weak self](data, response, error) in
                    
                    if error != nil {
                        print("Download Image Task Fail: \(error!.localizedDescription)")
                        return
                    } else {
                        //解析下載回來的檔案
                        DispatchQueue.main.async {
                            guard let response = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) else {
                                return
                            }
                            responseDict = response as? NSDictionary
                            //存取下載回來的檔案
                            infoDataManager.editInfoForDownload(originalItem: nil, completion: { (success, item) in
                                guard success == true else {
                                    return
                                }
                                do {
                                    try usersDataManager.userItem?.managedObjectContext?.save()
                                } catch {
                                    let error = error as NSError
                                    NSLog("Unresolve error\(error)")
                                }
                            })
                            alertController?.dismiss(animated: true, completion: nil)
                            self?.alert.setting(target: self!, title: "", message: "下載完成", BTNtitle: "OK")
                        }
                    }
                }).resume()
            }
        }
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
        
        guard let dataDict = downloadData else{
            return
        }
        var keyArray = Array(dataDict.keys)
        //選定databse裡的 record date
        let date = keyArray[indexPath.row]
        let desertRef = Storage.storage().reference().child(uuid!).child(date)
        let databaseRef = Database.database().reference().child("users").child(uuid!).child("record").child(date)
        alert.displayActivityIndicator(target: self, title: "刪除中\n")
        //移除storage的物件
        desertRef.delete(completion: {[weak self](error) in
            if let error = error {
                // Uh-oh, an error occurred!
                print(error)
                alertController?.dismiss(animated: true, completion: nil)
            } else {
                // File deleted successfully
                print("Child delete Correctly")
                //把alert消掉
                alertController?.dismiss(animated: true, completion: nil)
                self?.navigationController?.popToRootViewController(animated: true)
            }
        })
        //移除database裡的物件
        databaseRef.removeValue(completionBlock: {[weak self](error, refer) in
            if error != nil {
                print(error?.localizedDescription)
                alertController?.dismiss(animated: true, completion: nil)
            } else {
                print(refer)
                print("Child Removed Correctly")
            }
        })
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
 
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
