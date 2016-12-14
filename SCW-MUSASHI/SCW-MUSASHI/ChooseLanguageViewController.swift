//
//  ChooseLanguageViewController.swift
//  SCW-MUSASHI
//
//  Created by leo on 09/11/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class ChooseLanguageViewController: UIViewController {
    
    @IBOutlet weak var loada: UIActivityIndicatorView!
    @IBOutlet weak var load: UIView!
    @IBOutlet weak var lbLanguage2: UILabel!
    @IBOutlet weak var lbLanguage1: UILabel!
    @IBOutlet weak var lbChoose1: UILabel!
    @IBOutlet weak var lbChoose2: UILabel!
    
    @IBOutlet weak var bt1: UIButton!
    @IBOutlet weak var bt2: UIButton!
    var verificador = false
    let checkOff = Layout.sizeImage(width: 30, height: 30, image: #imageLiteral(resourceName: "check_off"))
    let checkOn = Layout.sizeImage(width: 30, height: 30, image: #imageLiteral(resourceName: "check_on"))
    var selectedButton = 1
    var linguagens = [[String]]()
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        loada.startAnimating()
        bt1.setImage(checkOff, for: .normal)
        bt2.setImage(checkOn, for: .normal)
        
        let ip = defaults.object(forKey: "IP") as! String
        Helper.GET(urlString: "\(ip)/scw/ws_config/get_labels") { (jsonRecebe) in
            self.separa(json: jsonRecebe)
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
    }
    
    func separa(json: Dictionary<String, AnyObject>) {
        let x = json["data"] as! [[String: Any]]
        print(x.count)
        
        Helper.separaString(json: x) { (values) in
            DispatchQueue.main.async {
                
                self.linguagens = values
                self.lbLanguage1.text = self.linguagens[10][0]
                self.lbLanguage2.text = self.linguagens[10][1]
                self.lbChoose1.text = self.linguagens[14][0]
                self.lbChoose2.text = self.linguagens[14][1]
                self.loada.stopAnimating()
                self.load.isHidden = true
            }
        }
        
        
//        for y in x {
//            if let query = y["field"] as? String {
//                if query == "lang_selection" {
//                    if let value = y["value"]as? [String] {
//                        print(value)
//                        DispatchQueue.main.async {
//                            self.loada.stopAnimating()
//                            self.load.isHidden = true
//                            self.lbLanguage1.text = value[0]
//                            self.lbLanguage2.text = value[1]
//                        }
//                        
//                    }
//                } else {
//                    
//                }
//            }
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func acao1(_ sender: AnyObject) {
        selectedButton = 0
        mudarBotao(bt1: bt1, bt2: bt2)
        
    }
    
    @IBAction func entrar(_ sender: AnyObject) {
        print(selectedButton)
        DAO.selectedLanguage(language: linguagens, i: selectedButton)
        DispatchQueue.main.async {
            self.defaults.set(self.selectedButton, forKey: "label")
            if (self.navigationController?.viewControllers[1].isKind(of: HomeViewController.self))! {
                _ = self.navigationController?.popViewController(animated: true)
            } else {
                self.defaults.set(1, forKey: "logado")
                let vc = self.storyboard!.instantiateViewController(withIdentifier: "home") as! HomeViewController
                self.navigationController?.pushViewController(vc, animated: false)
            }
        }
        
        
    }
    @IBAction func acao2(_ sender: AnyObject) {
        
        selectedButton = 1
        mudarBotao(bt1: bt2, bt2: bt1)
    }
    
    func mudarBotao(bt1: UIButton, bt2: UIButton) {
        
        bt1.setImage(checkOn, for: .normal)
        bt2.setImage(checkOff, for: .normal)
        
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
