//
//  Helper.swift
//  SCW-MUSASHI
//
//  Created by leo on 08/11/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class Helper {
    
    static func separaString(json : [[String : Any]], completion:  @escaping (_ results: [[String]]) -> Void) {
        var value = [[String]]()
        var count = 0
        for data in json {
            let field = data["field"] as! String
            
            if field == "lang_selection" || field == "ttl_choose_language" || field == "ttl_menu_logout" || field == "btn_reject" || field == "btn_comment" || field == "btn_accept" || field == "btn_done" || field == "btn_finish" || field == "btn_close" || field == "ttl_sector" || field == "ttl_date_time" || field == "ttl_operator" || field == "btn_confirm" || field == "txt_question_route_call" || field == "btn_yes" || field == "btn_no" || field == "ttl_menu_about" || field == "ttl_menu_language" || field == "ttl_issue" || field == "ttl_queries" || field == "ttl_foward" || field == "ttl_approved"{
                if let values = data["value"] as? [String] {
                    print("\(count) - \(values)")
                    value.append(values)
                    count += 1
                }
            }
        }
        
        completion(value)
    }
    
}

extension UIColor {
    
    var backGround: UIColor {
        return HexToColor(hexString: "#151D23")
    }
    
    var verde: UIColor {
        return HexToColor(hexString: "#4F9E60")
    }
    
    var atribuirBG: UIColor {
        return HexToColor(hexString: "#282D36")
    }
    
    var laranja: UIColor {
        return HexToColor(hexString: "#E1891B")
    }
    
    
    func HexToColor(hexString: String, alpha:CGFloat? = 1.0) -> UIColor {
        // Convert hex string to an integer
        let hexint = Int(self.intFromHexString(hexStr: hexString))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        let alpha = alpha!
        // Create color object, specifying alpha as well
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    
    func intFromHexString(hexStr: String) -> UInt32 {
        var hexInt: UInt32 = 0
        // Create scanner
        let scanner: Scanner = Scanner(string: hexStr)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = NSCharacterSet(charactersIn: "#") as CharacterSet
        // Scan hex value
        scanner.scanHexInt32(&hexInt)
        return hexInt
    }
    
    class func imageWithColor(color: UIColor, size: CGSize = CGSize(width: 60, height: 60)) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height);        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        context!.setFillColor(color.cgColor);
        context!.fill(rect);
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext();
        
        return image!;
    }
}


extension UIView {
    func showAnimation(view:UIView) {
        view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        view.alpha = 0.0
        UIView.animate(withDuration: 0.25) {
            view.alpha = 1.0
            view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
    
    func removeAnimate(view: UIView) {
        UIView.animate(withDuration: 0.25, animations: {
            view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            view.alpha = 0.0
        }, completion: { (finished: Bool) in
            if finished {
                view.removeFromSuperview()
            }
        })
    }
}
