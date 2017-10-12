//
//  MyTableViewCell.swift
//  noteForU
//
//  Created by Willy on 2017/9/28.
//  Copyright © 2017年 Willy. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var titleColor: UIView!
    @IBOutlet weak var bodyColor: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bodyColor.clipsToBounds = true
        titleColor.clipsToBounds = true
        contentLabel.clipsToBounds = true
        dateLabel.clipsToBounds = true
        
        bodyColor.layer.cornerRadius = 10
        
    }
    
    override var frame: CGRect {
        didSet{
            var newFrame = frame
//            newFrame.origin.y += 10;//整体向下 移动10
            newFrame.size.height -= 10//间隔为10
            newFrame.origin.x += 10
            newFrame.size.width -= 20
            super.frame = newFrame
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
