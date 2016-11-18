//
//  Cell1TableViewCell.swift
//  SCW-MUSASHI
//
//  Created by leo on 11/11/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class Cell1TableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbLinha: UILabel!
    @IBOutlet weak var lbOperador: UILabel!
    @IBOutlet weak var ldData: UILabel!
    
    
    @IBOutlet weak var sector: UILabel!
    
    @IBOutlet weak var operador: UILabel!
    @IBOutlet weak var dataHora: UILabel!
    
    
    
    
    var informacoes: [String: Any]? {
        didSet {
            if let operador = informacoes?["employee_name"] as? String {
                lbOperador.text = operador
            }
            
            if let operador = informacoes?["employee_name"] as? String {
                lbOperador.text = operador
            }
            
            if let linha = informacoes?["cost_center"] as? Int {
                lbLinha.text = "\(linha)"
            }
            
            if let data = informacoes?["created"] as? String {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
                let myDate = dateFormatter.date(from: data)!
                
                dateFormatter.dateFormat = "dd/MM/YYYY - HH:mm"
                let somedateString = dateFormatter.string(from: myDate)
                
                ldData.text = somedateString
            }
            
            sector.text = DAO.LinguagemSalvas(str: "sector")
            operador.text = DAO.LinguagemSalvas(str: "operador")
            dataHora.text = DAO.LinguagemSalvas(str: "date")
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
