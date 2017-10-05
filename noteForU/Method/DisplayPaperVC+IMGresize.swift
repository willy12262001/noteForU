//
//  DisplayPaperVC+IMGresize.swift
//  noteForU
//
//  Created by Willy on 2017/10/5.
//  Copyright © 2017年 Willy. All rights reserved.
//

import Foundation

extension DisplayPaperViewController {
    
    func resizeImgage(input:UIImage) -> UIImage {
        let maxLength = 1024 as CGFloat
        
        var finalImage:UIImage? = nil
        var targetSize:CGSize? = nil
        
        //check the image is smaller than 1024x1024
        if input.size.width <= maxLength && input.size.height <= maxLength {
            
            finalImage = input
            targetSize = input.size
            
        } else if input.size.width >= input.size.height {
            
            let ratio = input.size.width / maxLength
            targetSize = CGSize(width: maxLength, height: input.size.height / ratio)
            
        } else { //width < height
            
            let ratio = input.size.height / maxLength
            targetSize = CGSize(width: input.size.width / ratio, height:maxLength )
            
        }
        //Perform Image Resize.
        if finalImage == nil {
            
            UIGraphicsBeginImageContext(targetSize!)
            input.draw(in: CGRect(x: 0, y: 0, width: (targetSize?.width)!, height: (targetSize?.height)!))
            finalImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
        }
        
        return finalImage!
    }
}
