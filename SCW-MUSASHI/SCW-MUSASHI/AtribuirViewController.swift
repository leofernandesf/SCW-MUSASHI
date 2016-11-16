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
    var id: Int?
    
    var users: [[String : Any]]?
    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.tableFooterView = UIView(frame: .zero)
        print(id)
        if let idIssue = id {
            Helper.GET(urlString: "http://191.168.20.202/scw/ws_issue/get_assigned_users/\(idIssue)") { (result) in
                self.pegarUser(json: result)
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    func pegarUser(json: [String: Any]) {
        self.users = [[String: Any]]()
        let success = json["success"] as! Bool
        print(success)
        if success {
            let data = json["employee"] as! [[String: Any]]
            
            self.users = data
            DispatchQueue.main.async {
                self.myTable.reloadData()
            }
        }
        

    }
    
    @IBAction func voltar(_ sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
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
        let viewCustom = UIView()
        viewCustom.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        cell.selectedBackgroundView = viewCustom
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users?.count ?? 0
    }
}

extension AtribuirViewController: UITabBarDelegate {
    
}
