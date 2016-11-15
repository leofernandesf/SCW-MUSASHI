//
//  HomeTableViewCell.swift
//  SCW-MUSASHI
//
//  Created by leo on 10/11/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lbUser: UILabel!
    @IBOutlet weak var lbFuncao: UILabel!
    @IBOutlet weak var lbData: UILabel!
    var informacoes: [String: Any]? {
        didSet {
            print(informacoes?["employee"])
            if let user = informacoes?["employee"] as? Int {
                lbUser.text = "#\(user)"
            }
            
            if let funcao = informacoes?["issue_category"] as? String {
                lbFuncao.text = funcao
            }
            
            if let data = informacoes?["created"] as? String {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
                let myDate = dateFormatter.date(from: data)!
                
                dateFormatter.dateFormat = "dd/MM/YYYY"
                let somedateString = dateFormatter.string(from: myDate)
                
                lbData.text = somedateString
            }
            
        }
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
