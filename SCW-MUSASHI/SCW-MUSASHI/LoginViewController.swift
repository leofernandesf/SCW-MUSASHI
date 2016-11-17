//
//  LoginViewController.swift
//  SCW-MUSASHI
//
//  Created by leo on 08/11/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var lAnimation: UIActivityIndicatorView!
    @IBOutlet weak var load: UIView!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfSenha: UITextField!
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Layout.tfLayout(tfs: [tfEmail,tfSenha])
        
        
        let verificador = defaults.object(forKey: "logado") as! Int
        
        if verificador == 1 {
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "home") as!HomeViewController
            self.navigationController?.pushViewController(vc, animated: false)
        }
        
    }
    
    @IBAction func Entrar(_ sender: AnyObject) {
        self.load.isHidden = false
        self.lAnimation.startAnimating()
        let url = "http://191.168.20.202/scw/ws_mobile/login/"
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
                self.defaults.set(1, forKey: "logado")
                self.lAnimation.stopAnimating()
                self.load.isHidden = true
                let vc = self.storyboard!.instantiateViewController(withIdentifier: "chooseLanguage") as! ChooseLanguageViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            //print(userData)
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
