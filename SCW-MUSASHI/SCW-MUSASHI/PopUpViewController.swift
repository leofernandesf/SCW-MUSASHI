//
//  PopUpViewController.swift
//  SCW-MUSASHI
//
//  Created by leo on 14/11/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    var color: UIColor!
    var idIssue: Int?
    var idCategory: Int?
    
    
    @IBOutlet weak var lbMensagem: UILabel!
    @IBOutlet weak var loada: UIActivityIndicatorView!
    @IBOutlet weak var load: UIView!
    @IBOutlet weak var btNao: UIButton!
    @IBOutlet weak var btSim: UIButton!
    
    @IBOutlet weak var myView: UIView!
    
    let userDefault = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myView.layer.borderWidth = 4
        myView.layer.borderColor = UIColor.white.cgColor
        myView.layer.cornerRadius = 25
        myView.clipsToBounds = true
        self.myView.backgroundColor = color
        self.view.showAnimation(view: self.view)
        print(idCategory)
        lbMensagem.text = DAO.LinguagemSalvas(str: "popUp")
        btNao.setTitle(DAO.LinguagemSalvas(str: "nao"), for: .normal)
        btSim.setTitle(DAO.LinguagemSalvas(str: "sim"), for: .normal)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func nao(_ sender: AnyObject) {
        self.view.removeAnimate(view: self.view)
    }
    
    @IBAction func sim(_ sender: AnyObject) {
        self.load.isHidden = false
        self.loada.startAnimating()
        var id = Int()
        var category = Int()
        if let ID = idIssue {
            id = ID
        }
        
        if let CATEGORY = idCategory {
            category = CATEGORY
        }
        let url = "\(id)/\(category)"
        print(url)
        MusashiService.GET(urlType: .changeCategory, id: url) { (result) in
            print(result)
            self.loada.stopAnimating()
            self.load.isHidden = true
            DispatchQueue.main.async {
                for controller in self.navigationController!.viewControllers as Array {
                    if controller.isKind(of: HomeViewController.self) {
                        _ = self.navigationController?.popToViewController(controller as UIViewController, animated: true)
                        break
                    }
                }
            }
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
