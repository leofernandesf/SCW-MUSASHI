//
//  Layout.swift
//  SCW-MUSASHI
//
//  Created by leo on 08/11/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class Layout {
    
    static func tfLayout(tfs:[UITextField]) {
        for tf in tfs {
            print("endtro")
            tf.layer.borderColor = UIColor.white.cgColor
            tf.layer.borderWidth = 1.0
        }
    }
    
    
    static func sizeImage(width: CGFloat, height: CGFloat, image: UIImage) -> UIImage{
        let pinImage = image
        let size = CGSize(width: width , height: height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        pinImage.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage!
    }
    
    
    
}
