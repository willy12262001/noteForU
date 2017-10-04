//
//  MyCollectionViewCell.swift
//  noteForU
//
//  Created by Willy on 2017/9/27.
//  Copyright © 2017年 Willy. All rights reserved.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    //title顏色
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    //身體顏色
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        dateLabel.clipsToBounds = true
        contentLabel.clipsToBounds = true
        containerView.clipsToBounds = true
        
        containerView.layer.cornerRadius = 10
    }
}
