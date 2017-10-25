//
//  UploadTableViewController.swift
//  noteForU
//
//  Created by Willy on 2017/10/25.
//  Copyright © 2017年 Willy. All rights reserved.
//

import UIKit
import Firebase

class UploadTableViewController: UITableViewController {

    var firebaseTimeArray = [String]()
    let alert = AlertSetting()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usersDataManager.userItem?.info?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath)
        let info = usersDataManager.userItem?.info?.allObjects[indexPath.row] as! Info
        let currentDate = info.dateString
        cell.textLabel?.text = currentDate
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let allInfo = usersDataManager.userItem?.info?.allObjects
        guard allInfo?.count != 0 else {
            return
        }
        //要上傳的檔案
        let info = usersDataManager.userItem?.info?.allObjects[indexPath.row] as! Info
        //從data轉換成str
        let colorData = info.color
        let colorLData = info.colorL
        let date = info.dateString
        let attStringData = info.attStr
        
        let attString = attStringData?.base64EncodedString(options: .lineLength64Characters)
        let colorString = colorData?.base64EncodedString(options: .lineLength64Characters)
        let colorLString = colorLData?.base64EncodedString(options: .lineLength64Characters)

        //把coredata資料打包成JSON
        let parameters:[String:Any] = ["attStr":attString,"color":colorString,"colorL":colorLString,"date":date]
        
        guard let data = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) else{
            return
        }
        //MARK: - Upload
        //上傳
        alert.displayActivityIndicator(target: self, title: "上傳中\n")
        let databaseRef = Database.database().reference().child("users").child(uuid!).child("record").child(date!)
        let storageRef = Storage.storage().reference().child(uuid!).child(date!)
        let uploadtask = storageRef.putData(data, metadata: nil)
        uploadtask.observe(.success) { (snapshot) in
    
            guard let displayName = Auth.auth().currentUser?.displayName else{
                return
            }
            //database的參照，把資料存在storage後在存到database裡
            if let dataURL = snapshot.metadata?.downloadURL()?.absoluteString{
                let post: [String:Any] = ["data": dataURL]
                databaseRef.setValue(post)
            }
            //
            alertController?.dismiss(animated: true, completion: nil)
            let alert = UIAlertController(title: "資料備份成功!", message: nil, preferredStyle: .alert)
            let cancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
            
        }
        //上傳失敗
        uploadtask.observe(.failure) { (snapshot) in
            if let error = snapshot.error {
                print(error.localizedDescription)
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

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
