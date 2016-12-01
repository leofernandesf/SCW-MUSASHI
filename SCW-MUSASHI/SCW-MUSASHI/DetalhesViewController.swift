//
//  DetalhesViewController.swift
//  SCW-MUSASHI
//
//  Created by leo on 10/11/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class DetalhesViewController: UIViewController {
    
    @IBOutlet weak var load: UIView!
    @IBOutlet weak var btShare: UIButton!
    @IBOutlet weak var lbUsiario: UILabel!
    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    @IBOutlet weak var btComentar: UIButton!
    @IBOutlet weak var btAceitar: UIButton!
    @IBOutlet weak var btReject: UIButton!
    @IBOutlet weak var btDone: UIButton!
    
    let userDefault = UserDefaults.standard
    var recebe: [String: Any]!
    override func viewDidLoad() {
        super.viewDidLoad()
        let image = Layout.sizeImage(width: 24, height: 24, image: #imageLiteral(resourceName: "share2"))
        btShare.setImage(image, for: .normal)
        let usuario = recebe["employee"] as! Int
        print(usuario)
        self.lbUsiario.text = "#\(usuario)"
        setButtons(bts: [btComentar, btAceitar,btReject,btDone])
        
        btComentar.setTitle(DAO.LinguagemSalvas(str: "comentar"), for: .normal)
        btAceitar.setTitle(DAO.LinguagemSalvas(str: "aceitar"), for: .normal)
        
        if let contMenu = userDefault.object(forKey: "contMenu") as? Int {
            if contMenu == 3 {
                btReject.setTitle(DAO.LinguagemSalvas(str: "close"), for: .normal)
                btDone.setTitle(DAO.LinguagemSalvas(str: "finish"), for: .normal)
            } else {
                btReject.setTitle(DAO.LinguagemSalvas(str: "reject"), for: .normal)
                btDone.setTitle(DAO.LinguagemSalvas(str: "done"), for: .normal)
            }
        }
        //myTable.tableFooterView = UIView(frame: .zero)
        
        //        if let title = recebe["employee"] as? String {
        //            print(title)
        //            self.lbUsiario.text = title
        //        }
        // Do any additional setup after loading the view.
    }
    
    func setButtons(bts: [UIButton]) {
        for bt in bts {
            bt.layer.cornerRadius = 30
            bt.setBackgroundImage(UIColor.imageWithColor(color: UIColor.black.withAlphaComponent(0.7)), for: .highlighted)
            bt.clipsToBounds = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async {
            self.myTable.delegate = self
            self.myTable.dataSource = self
            self.myTable.reloadData()
            
        }
        
    }
    
    @IBAction func voltar(_ sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func encaminhar(_ sender: AnyObject) {
        performSegue(withIdentifier: "encaminhar", sender: self)
    }
    
    @IBAction func comentar(_ sender: AnyObject) {
        performSegue(withIdentifier: "comentar", sender: self)
    }
    
    @IBAction func aceitar(_ sender: AnyObject) {
        performSegue(withIdentifier: "atribuir", sender: self)
    }
    
    @IBAction func rejeitar(_ sender: Any) {
        self.load.isHidden = false
        self.loader.startAnimating()
        let contMenu = userDefault.object(forKey: "contMenu") as! Int
        var status = Int()
        if contMenu == 2 {
            status = 4
        } else {
            status = 5
        }
        
        
        post(status: status)
    }
    
    @IBAction func done(_ sender: Any) {
        self.load.isHidden = false
        self.loader.startAnimating()
        let contMenu = userDefault.object(forKey: "contMenu") as! Int
        var status = Int()
        if contMenu == 2 {
            status = 3
        } else {
            status = 6
        }
        post(status: status)
    }
    
    func post(status: Int) {
        if let id = recebe["id"] as? Int, let userNome = userDefault.object(forKey: "userName") as? String {
            
            let parameters: [String: Any] = ["id": id, "user": userNome, "status": status]
            print(parameters)
            Helper.POST(urlString: "http://191.168.20.202/scw/ws_mobile/set_status/", postString: parameters, completion: { (result) in
                print(result)
                if let success = result["success"] as? Bool {
                    if success {
                        DispatchQueue.main.async {
                            self.load.isHidden = true
                            self.loader.stopAnimating()
                            _ = self.navigationController?.popViewController(animated: true)
                        }
                    }
                }
            })
        }
        
    }
    
    
    
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "comentar" {
            let vc = segue.destination as! ComentarViewController
            if let usuario = recebe["employee"] as? Int {
                vc.titulo = usuario
            }
            
            if let id = recebe["id"] as? Int {
                vc.idIssue = id
            }
            
        } else if segue.identifier == "atribuir" {
            let vc = segue.destination as! AtribuirViewController
            if let id = recebe["id"] as? Int {
                vc.id = id
            }
        } else if segue.identifier == "encaminhar" {
            let vc = segue.destination as! EncaminharViewController
            if let id = recebe["id"] as? Int {
                vc.id = id
            }
        }
    }
    
    
}


extension DetalhesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if indexPath.row == 0 {
            let Customcell = tableView.dequeueReusableCell(withIdentifier: "cellDetalhe") as! Cell1TableViewCell
            Customcell.informacoes = recebe
            cell = Customcell
        } else if indexPath.row == 1 {
            let Customcell = tableView.dequeueReusableCell(withIdentifier: "cellDetalhe2") as! Cell2TableViewCell
            Customcell.informacoes = recebe
            cell = Customcell
        } else if indexPath.row == 2 {
            let Customcell = tableView.dequeueReusableCell(withIdentifier: "cellDetalhe3") as! Cell3TableViewCell
            if let id = recebe["id"] as? Int {
                Customcell.id = id
            }
            cell = Customcell
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
}

extension DetalhesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 102
        } else if indexPath.row == 1 {
            return 80
        } else {
            print(tableView.frame.size.height)
            return (tableView.frame.size.height - 190)
        }
    }
    
    
    
}
