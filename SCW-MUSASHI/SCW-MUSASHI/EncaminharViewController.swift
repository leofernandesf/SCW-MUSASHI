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
    var results: [String : Any]?
    var color = UIColor()
    var id: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTable.tableFooterView = UIView(frame: .zero)
        
        pegarInformacaio()
        print(id)
        // Do any additional setup after loading the view.
    }
    
    func pegarInformacaio() {
        if results == nil {
            Helper.GET(urlString: "http://191.168.20.202/scw/ws_toten/get_issues_categories") { (result) in
                self.results = result
                self.mostrarNodes(pais: self.results!)
            }
        } else {
            self.mostrarNodes(pais: self.results!)
        }
        
        
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return nodes?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellEnc") as! EncaminharTableViewCell
        cell.informacao = nodes?[indexPath.section]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
}

extension EncaminharViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewSection = UIView()
        viewSection.backgroundColor = UIColor.clear
        return viewSection
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.section)
        if let id = nodes?[indexPath.section]["id"] as? Int {
            self.node = id
        }
        
        if let colorBG = nodes?[indexPath.section]["bg_color"] as? String {
            print(colorBG)
            self.color = UIColor.black.HexToColor(hexString: colorBG)
        }
        
        
        self.proximaView()
//        print("vi")
//        //let cell = tableView.cellForRow(at: indexPath) as! EncaminharTableViewCell
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cellEnc", for: indexPath) as! EncaminharTableViewCell
//        //let cell = tableView.dequeueReusableCell(withIdentifier: "cellEnc") as! EncaminharTableViewCell
//        self.node = cell.id
//        self.color = cell.backgroundColor!
//        print(cell.id)
//        self.proximaView()
    }
    
    func proximaView() {
        
        let datas = results?["data"] as! [[String: Any]]
        var nodes2 = [[String : Any]]()
        for data in datas {
            if let nodee = data["node"] as? Int {
                if nodee == node {
                    nodes2.append(data)
                }
            }
        }
        if nodes2.count != 0 {
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "encaminhar") as! EncaminharViewController
            vc.results = results
            vc.node = node
            vc.id = id
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "popUp") as! PopUpViewController
            controller.color = color
            controller.idCategory = node
            controller.idIssue = self.id
            self.addChildViewController(controller)
            controller.view.frame = self.view.frame
            self.view.addSubview(controller.view)
            controller.didMove(toParentViewController: self)
        }
    }
    
    
}




