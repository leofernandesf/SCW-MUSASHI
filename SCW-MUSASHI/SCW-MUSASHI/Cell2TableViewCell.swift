//
//  Cell2TableViewCell.swift
//  SCW-MUSASHI
//
//  Created by leonardo fernandes farias on 15/11/16.
//  Copyright © 2016 br.com.tap4mobile. All rights reserved.
//

import UIKit

class Cell2TableViewCell: UITableViewCell {

    @IBOutlet weak var tvCategorias: UITextView!
    
    var informacoes: [String: Any]? {
        didSet {
            if let str = informacoes?["category_tree"] as? String {
                print(str)
                tvCategorias.text = str
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
