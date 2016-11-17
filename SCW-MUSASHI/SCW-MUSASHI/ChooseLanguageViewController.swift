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
    @IBOutlet weak var bt1: UIButton!
    @IBOutlet weak var bt2: UIButton!
    var verificador = false
    let checkOff = Layout.sizeImage(width: 30, height: 30, image: #imageLiteral(resourceName: "check_off"))
    let checkOn = Layout.sizeImage(width: 30, height: 30, image: #imageLiteral(resourceName: "check_on"))
    var selectedButton = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loada.startAnimating()
        bt1.setImage(checkOff, for: .normal)
        bt2.setImage(checkOn, for: .normal)
        Helper.GET(urlString: "http://191.168.20.202/scw/ws_config/get_labels") { (jsonRecebe) in
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
        for y in x {
            if let query = y["field"] as? String {
                if query == "lang_selection" {
                    if let value = y["value"]as? [String] {
                        print(value)
                        DispatchQueue.main.async {
                            self.loada.stopAnimating()
                            self.load.isHidden = true
                            self.lbLanguage1.text = value[0]
                            self.lbLanguage2.text = value[1]
                        }
                        
                    }
                } else {
                    
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func acao1(_ sender: AnyObject) {
        selectedButton = 1
        mudarBotao(bt1: bt1, bt2: bt2)
        
    }
    
    @IBAction func entrar(_ sender: AnyObject) {
        print(navigationController?.viewControllers.count)
        if (navigationController?.viewControllers[1].isKind(of: HomeViewController.self))! {
            _ = self.navigationController?.popViewController(animated: true)
        } else {
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "home") as! HomeViewController
            self.navigationController?.pushViewController(vc, animated: false)
        }
        
    }
    @IBAction func acao2(_ sender: AnyObject) {
        
        selectedButton = 2
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
