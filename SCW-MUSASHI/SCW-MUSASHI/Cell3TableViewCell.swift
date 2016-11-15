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
    
    var id: Int? {
        didSet {
            let url = "http://191.168.20.202/scw/ws_mobile/get_comments/\(id!)"
            print(url)
            Helper.GET(urlString: url) { (result) in
                
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
        let data = comentarios["data"] as! [[String : Any]]
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
            print(coment["Date"])
        }
        print(str)
        DispatchQueue.main.async {
            self.tvComentarios.text = str
        }
        
    }
    
}
