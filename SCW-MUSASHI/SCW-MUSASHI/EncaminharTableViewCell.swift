//
//  EncaminharTableViewCell.swift
//  SCW-MUSASHI
//
//  Created by leo on 14/11/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class EncaminharTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbText: UILabel!
    var informacao: [String : Any]? {
        didSet {
            
            if let colorBG = informacao?["bg_color"] as? String {
                print(colorBG)
                lbText.text = "vat"
                let col = UIColor.black.HexToColor(hexString: colorBG)
                self.backgroundColor = col
            }
            setBackGround()
        }
    }
    
    func setBackGround() {
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
