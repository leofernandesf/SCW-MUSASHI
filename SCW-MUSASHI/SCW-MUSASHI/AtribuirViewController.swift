//
//  AtribuirViewController.swift
//  SCW-MUSASHI
//
//  Created by leo on 10/11/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class AtribuirViewController: UIViewController {
    
    @IBOutlet weak var myTable: UITableView!
    
    @IBOutlet weak var load: UIView!
    @IBOutlet weak var loada: UIActivityIndicatorView!
    
    @IBOutlet weak var btConfirmar: UIButton!
    var id: Int?
    var ids = [Any]()
    var users: [[String : Any]]?
    let userDefault = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.tableFooterView = UIView(frame: .zero)
        loada.startAnimating()
        print(id)
        if let idIssue = id {
            MusashiService.GET(urlType: .assignedUser, id: idIssue.description, completion: { (result) in
                self.pegarUser(json: result)
            })
        }
        
        btConfirmar.setTitle(DAO.LinguagemSalvas(str: "confirmar"), for: .normal)
        // Do any additional setup after loading the view.
    }
    
    func pegarUser(json: [String: Any]) {
        self.users = [[String: Any]]()
        let success = json["success"] as! Bool
        print(success)
        if success {
            let data = json["employee"] as! [[String: Any]]
            
            self.users = data
            
        } else {
            let selfUser = pegarSelfUser()
            self.users = [selfUser]
        }
        
        DispatchQueue.main.async {
            self.pegarAssigned()
            self.loada.stopAnimating()
            self.load.isHidden = true
            self.myTable.reloadData()
        }

    }
    
    func pegarAssigned() {
        ids = [Any]()
        for user in users! {
            if let assigned = user["assigned"] as? Bool, let userId = user["id"]  {
                if assigned == true {
                    ids.append(userId)
                    
                }
            }
        }
        print(ids)
        
    }
    
    func pegarSelfUser() -> [String : Any] {
        let userdefault = UserDefaults.standard
        let nome = userdefault.object(forKey: "userName") as! String
        let userId = userdefault.object(forKey: "userId") as! Int
        let function = userdefault.object(forKey: "jobTitle") as! String
        var selfUser = [String : Any]()
        selfUser = ["id" : userId, "assigned" : 0, "name" : nome, "function" : function]
        return selfUser
    }
    
    @IBAction func voltar(_ sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func confirmar(_ sender: Any) {
        pegarAssigned()
        let parameters: [String: Any] = [ "success" : true, "data": ids ]
        print(parameters)
        if let idIssue = id {
            print(idIssue)
            MusashiService.POST(urlType: .setAssignedUser, postString: parameters, id: idIssue.description, completion: { (result) in
                print(result)
            })
            
            _ = self.navigationController?.popViewController(animated: true)
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

extension AtribuirViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellAtri") as! atribuirTableViewCell
        cell.user = users?[indexPath.row]
//        let viewCustom = UIView()
////        viewCustom.backgroundColor = UIColor.black.withAlphaComponent(0.1)
////        viewCustom.backgroundColor = UIColor.black.withAlphaComponent(0.1)
//        cell.selectedBackgroundView = viewCustom
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users?.count ?? 0
    }
}

extension AtribuirViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.myTable.deselectRow(at: indexPath, animated: false)
        let cell = tableView.cellForRow(at: indexPath) as! atribuirTableViewCell
        if let assigned = cell.assigned  {
            if assigned == true {
                cell.assigned = false
                cell.ivCheck.image = #imageLiteral(resourceName: "icon_checkbox")
                self.users?[indexPath.row]["assigned"] = false
            } else {
                cell.assigned = true
                cell.ivCheck.image = #imageLiteral(resourceName: "icon_checkbox_select")
                self.users?[indexPath.row]["assigned"] = true
            }
        }
        
        
    }
    
    
    
}
