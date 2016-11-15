//
//  EncaminharViewController.swift
//  SCW-MUSASHI
//
//  Created by leo on 10/11/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class EncaminharViewController: UIViewController {
    
    @IBOutlet weak var myTable: UITableView!
    var node = 0
    var nodes : [[String : Any]]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Helper.GET(urlString: "http://191.168.20.202/scw/ws_toten/get_issues_categories") { (result) in
            self.mostrarNodes(pais: result)
        }
        // Do any additional setup after loading the view.
    }
    
    func mostrarNodes(pais: [String : Any]) {
        let datas = pais["data"] as! [[String: Any]]
        self.nodes = [[String : Any]]()
        for data in datas {
            if let nodee = data["node"] as? Int {
                if nodee == node {
                    self.nodes?.append(data)
                }
            }
        }
        
        DispatchQueue.main.async {
            self.myTable.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func voltar(_ sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func chamarPropriaView() {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "encaminhar") as! EncaminharViewController
        self.navigationController?.pushViewController(vc, animated: true)
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


extension EncaminharViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellEnc") as! EncaminharTableViewCell
        cell.informacao = nodes?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return nodes?.count ?? 0
    }
}

extension EncaminharViewController : UITableViewDelegate {
    
}




