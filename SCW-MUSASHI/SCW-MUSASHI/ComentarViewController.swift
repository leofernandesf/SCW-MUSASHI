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
    
    @IBOutlet weak var load: UIView!
    
    @IBOutlet weak var loada: UIActivityIndicatorView!
    
    
    let defaults = UserDefaults.standard
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
        dismissKeyboard()
        load.isHidden = false
        loada.startAnimating()
        if let id = idIssue {
            let userId = defaults.object(forKey: "userName") as! String
            let parameters: [String: Any] = [
                "success" : true,
                "data": [
                    "user" : userId,
                    "comment": tvComentario.text!
                ]
                
            ]
            print(parameters)
            let ip = defaults.object(forKey: "IP") as! String
            let url = "\(ip)/scw/ws_issue/new_comment/\(id)"
            print(url)
  
            MusashiService.POST(urlType: .newComment, postString: parameters, id: id.description, completion: { (sucess) in
                if let verificador = sucess["success"] as? Bool {
                    if verificador == true {
                        DispatchQueue.main.async {
                            self.loada.stopAnimating()
                            self.load.isHidden = true
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
