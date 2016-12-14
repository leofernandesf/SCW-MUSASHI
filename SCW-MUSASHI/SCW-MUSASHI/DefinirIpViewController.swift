//
//  DefinirIpViewController.swift
//  SCW-MUSASHI
//
//  Created by leo on 14/12/16.
//  Copyright © 2016 br.com.tap4mobile. All rights reserved.
//

import UIKit

class DefinirIpViewController: UIViewController {

    @IBOutlet weak var tfIP: UITextField!
    
    let userDefault = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        Layout.tfLayout(tfs: [tfIP])
        
        if let ip = userDefault.object(forKey: "IP") as? String {
            tfIP.text = ip
        } else {
            tfIP.text = "191.168.22.251"
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func OK(_ sender: Any) {
        let ipDigitado = tfIP.text!
        var concatenar = String()
        if (tfIP.text?.isEmpty)! {
            showMensage()
        } else {
            if ipDigitado.contains("http") {
                concatenar = ipDigitado
            } else {
                print("nao tem")
                concatenar = "http://\(ipDigitado)"
                print(concatenar)
            }
            userDefault.set(concatenar, forKey: "IP")
            _ = self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    
    func showMensage() {
        let alertController = UIAlertController(title: "Campo vazio.", message: "Por favor, informe um endereço IP ou uma url.", preferredStyle: .alert)
        
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
