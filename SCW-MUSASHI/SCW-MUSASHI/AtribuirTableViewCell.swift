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
    var user : [String : Any]? {
        didSet {
            print(user)
            if let nome = user?["name"] as? String {
                print(nome)
                self.lbNome.text = nome
            }
            
            if let cargo = user?["function"] as? String {
                print(cargo)
                self.lbCargo.text = cargo
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
