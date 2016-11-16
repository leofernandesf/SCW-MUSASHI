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
    @IBOutlet weak var myView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myView.layer.borderWidth = 4
        myView.layer.borderColor = UIColor.white.cgColor
        myView.layer.cornerRadius = 25
        myView.clipsToBounds = true
        self.myView.backgroundColor = color
        self.view.showAnimation(view: self.view)
        print(idCategory)
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
        var id = Int()
        var category = Int()
        if let ID = idIssue {
            id = ID
        }
        
        if let CATEGORY = idCategory {
            category = CATEGORY
        }
        let url = "http://191.168.20.202/scw/ws_issue/change_category/\(id)/\(category)"
        print(url)
        Helper.GET(urlString: url) { (result) in
            print(result)
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
