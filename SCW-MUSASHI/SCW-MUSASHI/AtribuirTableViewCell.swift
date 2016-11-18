//
//  atribuirTableViewCell.swift
//  SCW-MUSASHI
//
//  Created by leo on 14/11/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class atribuirTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var ivCheck: UIImageView!
    @IBOutlet weak var lbNome: UILabel!
    @IBOutlet weak var lbCargo: UILabel!
    @IBOutlet weak var lbNumero: UILabel!
    var assigned: Bool?
    var user : [String : Any]? {
        didSet {
            
            self.lbNumero.layer.cornerRadius = self.lbNumero.frame.size.width/2
            self.lbNumero.clipsToBounds = true
            if let nome = user?["name"] as? String {
                print(nome)
                self.lbNome.text = nome
            }
            
            if let cargo = user?["function"] as? String {
                print(cargo)
                self.lbCargo.text = cargo
            }
            
            if let assigned = user?["assigned"] as? Bool {
                self.assigned = assigned
                if assigned == true {
                    ivCheck.image = #imageLiteral(resourceName: "icon_checkbox_select")
                } else {
                    ivCheck.image = #imageLiteral(resourceName: "icon_checkbox")
                }
            }
            
            if let count = user?["count"] as? Int {
                print(count)
                lbNumero.text = "\(count)"
            } else {
                self.lbNumero.isHidden = true
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        self.ivCheck.image = selected ? #imageLiteral(resourceName: "icon_checkbox_select") : #imageLiteral(resourceName: "icon_checkbox")
//        // Configure the view for the selected state
//    }
    
}
