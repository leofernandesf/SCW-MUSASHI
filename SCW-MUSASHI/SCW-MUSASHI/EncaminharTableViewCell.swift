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
    let userDefault = UserDefaults.standard
    var id: Int!
    var node: Int!
    var informacao: [String : Any]? {
        didSet {
            if let colorBG = informacao?["bg_color"] as? String {
                print(colorBG)
                let col = UIColor.black.HexToColor(hexString: colorBG)
                self.backgroundColor = col
            }
            
            let label = userDefault.object(forKey: "label") as! Int
            
            if label == 0 {
                if let titulo = informacao?["label1"] as? String {
                    self.lbText.text = titulo
                }
            } else {
                if let titulo = informacao?["label2"] as? String {
                    self.lbText.text = titulo
                }
            }
            
            
            if let idJson = informacao?["id"] as? Int {
                self.id = idJson
            }
            if let nodeJson = informacao?["node"] as? Int {
                self.node = nodeJson
            }
            setBackGround()
        }
    }
    
    func setBackGround() {
        self.layer.cornerRadius = 25
        self.clipsToBounds = true
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
