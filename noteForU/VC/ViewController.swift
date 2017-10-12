//
//  ViewController.swift
//  noteForU
//
//  Created by Willy on 2017/9/27.
//  Copyright © 2017年 Willy. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var menuBTN: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        gesture?.turnOnMenu(target: menuBTN, VCtarget: self)
        
        collectionView.reloadData()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name:NSNotification.Name(rawValue:"NoteUUU"), object: nil)
    }
    //MARK: - Method
    @objc func reloadTableView()  {
        collectionView.reloadData()
    }
    //MARK: - BTN
    @IBAction func addItem(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PaperViewController") as! PaperViewController
        present(vc, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: - CollectionDelegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return infoDataManager?.totalCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath) as! MyCollectionViewCell
        
        if let item = infoDataManager?.fetchItemAt(index: indexPath.row) {
            cell.dateLabel.text = item.dateString
            
            let unarchiveAttStr = NSKeyedUnarchiver.unarchiveObject(with: item.attStr!) as! NSAttributedString
                
            cell.contentLabel.attributedText = unarchiveAttStr
            
            //設定 cell顏色
            let unarchiveColor = NSKeyedUnarchiver.unarchiveObject(with: item.color!)
            let unarchiveColorL = NSKeyedUnarchiver.unarchiveObject(with: item.colorL!)
            cell.containerView.backgroundColor = unarchiveColor as? UIColor
            cell.dateLabel.backgroundColor = unarchiveColorL as? UIColor
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DisplayPaperViewController") as! DisplayPaperViewController
        
        if let item = infoDataManager?.fetchItemAt(index: indexPath.row) {
            infoDataManager?.giveValue(toInfoItem: item)
        }
        present(vc, animated: true, completion: nil)
        
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    //設定cell 與view間距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        //(上,左,下,又)
        return UIEdgeInsetsMake(0, 5, 0, 5)
    }
    //設定cell上下間距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    //設定cell之間的間距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

