//
//  Cell3TableViewCell.swift
//  SCW-MUSASHI
//
//  Created by leo on 14/11/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class Cell3TableViewCell: UITableViewCell {
    @IBOutlet weak var tvComentarios: UITextView!
    @IBOutlet weak var load: UIView!
    @IBOutlet weak var loada: UIActivityIndicatorView!
    
    let userDefault = UserDefaults.standard
    
    var id: Int? {
        didSet {
            self.load.isHidden = false
            self.loada.startAnimating()
            MusashiService.GET(urlType: .comments, id: id!.description) { (result) in
                self.setComentarios(comentarios: result)
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
    
    func setComentarios(comentarios : [String : Any]) {
        print(comentarios)
        if let sucess = comentarios["success"] as? Bool {
            if sucess == true {
                if let data = comentarios["data"] as? [[String : Any]] {
                    var str = ""
                    var user = String()
                    var date = String()
                    var comentario = String()
                    for coment in data {
                        if let user2 = coment["User"] as? String {
                            user = user2
                        }
                        
                        if let coment2 = coment["Comment"] as? String {
                            comentario = coment2
                        }
                        
                        if let dia = coment["Date"] as? String {
                            //                let dateFormatter = DateFormatter()
                            //                dateFormatter.dateFormat = "YYYY-MM-dd HH:mm"
                            //                let myDate = dateFormatter.date(from: dia)!
                            //
                            //                dateFormatter.dateFormat = "dd/MM/YYYY - HH:mm"
                            //                date = dateFormatter.string(from: myDate)
                            date = dia
                        }
                        str += "\(user)\t\(date)\n\(comentario)\n\n"
                    }
                    print(str)
                    DispatchQueue.main.async {
                        self.loada.stopAnimating()
                        self.load.isHidden = true
                        self.tvComentarios.text = str
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.loada.stopAnimating()
                    self.load.isHidden = true
                }
                
            }
            
        }
        
        
        
    }
    
}
