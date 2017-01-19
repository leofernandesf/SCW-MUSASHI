//
//  LoginViewController.swift
//  SCW-MUSASHI
//
//  Created by leo on 08/11/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var recocnizerView: UIView!
    @IBOutlet weak var lAnimation: UIActivityIndicatorView!
    @IBOutlet weak var load: UIView!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfSenha: UITextField!
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        defaults.set("http://200.242.53.135", forKey: "IP")
        
        let tresDedos = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.gestureTres))
        tresDedos.numberOfTapsRequired = 1
        tresDedos.numberOfTouchesRequired = 3
        self.recocnizerView.addGestureRecognizer(tresDedos)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func gestureTres() {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "DefinirIP") as! DefinirIpViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
        print("val")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Layout.tfLayout(tfs: [tfEmail,tfSenha])
        print(defaults.object(forKey: "IP"))
        if let verificador = defaults.object(forKey: "logado") as? Int {
            if verificador == 1 {
                let vc = self.storyboard!.instantiateViewController(withIdentifier: "home") as!HomeViewController
                self.navigationController?.pushViewController(vc, animated: false)
            }
        }
        
        
        
    }
    
    @IBAction func Entrar(_ sender: AnyObject) {
        if let ip = defaults.object(forKey: "IP") as? String {
            print(ip)
            self.load.isHidden = false
            self.lAnimation.startAnimating()
            let url = "\(ip)/scw/ws_mobile/login/"
            //let postString = "{\"success\":\"true\", \"data\":{\"user\":\"\(tfEmail.text!)\", \"pass\":\"\(tfSenha.text!)\"}}"
            
            let parameters: [String: Any] = [
                "success" : true,
                "data": [
                    "user" : tfEmail.text!,
                    "pass": tfSenha.text!
                ]
                
            ]
            Helper.POST(urlString: url, postString: parameters) { (success) in
                print(success)
                self.verificar(strings: success)
                
            }
        } else {
            showMensage(titulo: "IP nao setado.", mensagem: "Por Favor, sete um valor para o IP.")
        }
        
    }
    
    func verificar(strings: [String: Any]) {
        let success = strings["success"] as! Bool
        var userData = Dictionary<String, AnyObject>()
        if success == true {
            print(success)
            userData = strings["data"] as! Dictionary<String, AnyObject>
            let job_tittle = userData["job_tittle"] as! String
            if job_tittle == "Admin" || job_tittle == "Admin" {
                self.defaults.set(3, forKey: "contMenu")
                
                
            } else {
                self.defaults.set(2, forKey: "contMenu")
            }
            self.defaults.set(job_tittle, forKey: "jobTitle")
            salvarUser(user: userData)
            DispatchQueue.main.async {
                self.tfEmail.text = ""
                self.tfSenha.text = ""
                self.lAnimation.stopAnimating()
                self.load.isHidden = true
                let vc = self.storyboard!.instantiateViewController(withIdentifier: "chooseLanguage") as! ChooseLanguageViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            //print(userData)
        } else {
            DispatchQueue.main.async {
                self.lAnimation.stopAnimating()
                self.load.isHidden = true
                self.showMensage(titulo: "Usuario invalido.", mensagem: "informe um usuario valido.")
            }
            
        }
    }
    
    func salvarUser(user: Dictionary<String, AnyObject>) {
        if let userId = user["id"] as? Int {
            self.defaults.set(userId, forKey: "userId")
        }
        
        if let userNome = user["name"] as? String {
            self.defaults.set(userNome, forKey: "userName")
        }
        
        if let userLogin = user["login"] as? String {
            self.defaults.set(userLogin, forKey: "login")
        }
     }
    
    func showMensage(titulo: String, mensagem: String) {
        let alertController = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        
        let buttonCancel = UIAlertAction(title: "OK", style: .cancel) { (action) -> Void in
            print("Cancel Button Pressed")
        }
        
        alertController.addAction(buttonCancel)
        
        present(alertController, animated: true, completion: nil)
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

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
