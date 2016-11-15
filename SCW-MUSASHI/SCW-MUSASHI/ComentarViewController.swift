//
//  ComentarViewController.swift
//  SCW-MUSASHI
//
//  Created by leo on 11/11/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class ComentarViewController: UIViewController {
    @IBOutlet weak var lbTitulo: UILabel!
    @IBOutlet weak var tvComentario: UITextView!
    var idIssue: Int!
    var idUser = Int()
    var titulo: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(titulo)
        
        if let user = titulo {
            lbTitulo.text = "#\(user)"
        }
        
        tvComentario.becomeFirstResponder()
        tvComentario.layer.borderWidth = 1.0
        tvComentario.layer.borderColor = UIColor.white.cgColor
        tvComentario.layer.cornerRadius = 5
        tvComentario.clipsToBounds = true
        
        if let id = idIssue {
            idIssue = id
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func voltar(_ sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func enviarComent(_ sender: AnyObject) {
        print(idIssue)
        if let id = idIssue {
            let user = titulo as Int
            let parameters: [String: Any] = [
                "success" : true,
                "data": [
                    "user" : user,
                    "comment": tvComentario.text!
                ]
                
            ]
            let url = "http://191.168.20.202/scw/ws_issue/new_comment/\(id)"
            //let postString = "{\"success\":\"true\", \"data\":{\"user\":\"\(user)\", \"comment\":\"\(tvComentario.text!)\"}}"
            Helper.POST(urlString: url, postString: parameters, completion: { (sucess) in
                if let verificador = sucess["success"] as? Int {
                    if verificador == 1 {
                        DispatchQueue.main.async {
                            _ = self.navigationController?.popViewController(animated: true)
                        }
                        
                    }
                    
                }
            })
        }
        
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
