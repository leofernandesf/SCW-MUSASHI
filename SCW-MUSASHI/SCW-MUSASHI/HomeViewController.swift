//
//  HomeViewController.swift
//  SCW-MUSASHI
//
//  Created by leo on 09/11/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var loada: UIActivityIndicatorView!
    @IBOutlet weak var load: UIView!
    @IBOutlet weak var ptSearch: UIButton!
    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var myCollection: UICollectionView!
    @IBOutlet weak var tfSearch: UITextField!
    
    var chamadas : [[String: Any]]?
    var consultas: [[String: Any]]?
    var pendencias: [[String: Any]]?
    
    var mostrarInformacoes: [[String: Any]]?
    var mostrarInformacoesAux: [[String: Any]]?
    var envia: [String: Any]!
    let defaults = UserDefaults.standard
    var cont = 2
    var index = IndexPath(item: 0, section: 0)
    let titulos = ["Consultas", "Chamados", "Aprovados"]
    var titulosCore = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load.isHidden = false
        loada.startAnimating()
        let image = Layout.sizeImage(width: 20, height: 20, image: #imageLiteral(resourceName: "ic_search"))
        ptSearch.setImage(image, for: .normal)
        if let contMenu = defaults.object(forKey: "contMenu") as? Int {
            print(contMenu)
            cont = contMenu
        }
        self.myTable.tableFooterView = UIView(frame: .zero)
        tfSearch.delegate = self
        titulosCore.append(DAO.LinguagemSalvas(str: "queries"))
        titulosCore.append(DAO.LinguagemSalvas(str: "issue"))
        titulosCore.append(DAO.LinguagemSalvas(str: "aprovado"))
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let ip = defaults.object(forKey: "IP") as! String
        Helper.GET(urlString: "\(ip)/scw/ws_issue/show") { (recebeJson) in

            print(recebeJson)
            self.separaChamadas(json: recebeJson)
            
        }
        
        
        myCollection.dataSource = self
        myCollection.delegate = self
        DispatchQueue.main.async {
            self.titulosCore = [String]()
            self.titulosCore.append(DAO.LinguagemSalvas(str: "queries"))
            self.titulosCore.append(DAO.LinguagemSalvas(str: "issue"))
            self.titulosCore.append(DAO.LinguagemSalvas(str: "aprovado"))
            self.myCollection.reloadData()
            self.myCollection.selectItem(at: self.index, animated: true, scrollPosition: .left)
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        
    }
    
    func separaChamadas(json: Dictionary<String, AnyObject>) {
        let x = json["data"] as! [[String: Any]]
        print(x.count)
        chamadas = [[String: Any]]()
        consultas = [[String: Any]]()
        pendencias = [[String : Any]]()
        for y in x {
            if let query = y["query"] as? Bool, let status = y["status_code"] as? Int {
                if query == true {
                    self.chamadas?.append(y)
                } else {
                    self.consultas?.append(y)
                }
                
                if status == 3 || status == 4 {
                    self.pendencias?.append(y)
                }
            }
        }
        print("chamadas: \(self.chamadas?.count) - consultas: \(self.consultas?.count)")
        if self.index.item == 0 {
            self.mostrarInformacoes = self.chamadas
        } else if self.index.item == 1{
            self.mostrarInformacoes = self.consultas
        } else {
            self.mostrarInformacoes = self.pendencias
        }
        
        
        DispatchQueue.main.async {
            self.loada.stopAnimating()
            self.load.isHidden = true
            self.mostrarInformacoesAux = self.mostrarInformacoes
            self.myTable.reloadData()
        }
    }
    
    @IBAction func opcoes(_ sender: AnyObject) {
        menuOpcoes()
    }
    
    
    func menuOpcoes() {
        let alert: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let idioma =  UIAlertAction(title: DAO.LinguagemSalvas(str: "ttlLanguage"), style: .default) { UIAlertAction in
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "chooseLanguage") as! ChooseLanguageViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        let sobre =  UIAlertAction(title: DAO.LinguagemSalvas(str: "sobre"), style: .default) { UIAlertAction in
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "sobre") as! SobreViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        let logOut =  UIAlertAction(title: DAO.LinguagemSalvas(str: "exit"), style: .default) { UIAlertAction in
            self.defaults.set(0, forKey: "logado")
            DAO.excluir()
            DispatchQueue.main.async {
                _ = self.navigationController?.popToRootViewController(animated: false)
            }
            
        }
        
        
        alert.addAction(idioma)
        alert.addAction(sobre)
        alert.addAction(logOut)
        
        self.present(alert, animated: true) {
            alert.view.superview?.subviews[1].isUserInteractionEnabled = true
            alert.view.superview?.subviews[1].addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(HomeViewController.alertControllerBackgroundTapped)))
        }
    }
    
    func alertControllerBackgroundTapped()
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detalhe" {
            let vc = segue.destination as! DetalhesViewController
            vc.recebe = envia
        }
    }
    
    
    
    @IBAction func bucar(_ sender: Any) {
        if (tfSearch.text?.isEmpty)! {
            DispatchQueue.main.async {
                self.mostrarInformacoes = self.mostrarInformacoesAux
                self.myTable.reloadData()
            }
            
        } else {
            let text: Int? = Int(tfSearch.text!)
            search(textBusca: text!)
            
            tfSearch.text = ""
        }
        dismissKeyboard()
    }
    
    func search(textBusca: Int) {
        var busca = [[String : Any]]()
        for informacao in mostrarInformacoes! {
            if let id = informacao["employee"] as? Int {
                if id == textBusca {
                    busca.append(informacao)
                }
            }
        }
        DispatchQueue.main.async {
            self.mostrarInformacoes = busca
            self.myTable.reloadData()
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

extension HomeViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCellCollectionViewCell
        cell.lbTitle.text = titulosCore[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cont
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.index = indexPath
        if indexPath.item == 0 {
            self.mostrarInformacoes = self.chamadas
        } else if indexPath.item == 1 {
            self.mostrarInformacoes = self.consultas
        } else if indexPath.item == 2 {
            self.mostrarInformacoes = self.pendencias
        }
        self.mostrarInformacoesAux = self.mostrarInformacoes
        myTable.reloadData()
    }
}


extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/CGFloat(cont), height: collectionView.frame.size.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
}



extension HomeViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTable", for: indexPath) as! HomeTableViewCell
        cell.informacoes = self.mostrarInformacoes?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mostrarInformacoes?.count ?? 0
    }
}


extension HomeViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        self.envia = mostrarInformacoes?[indexPath.row]
        self.performSegue(withIdentifier: "detalhe", sender: self)
    }
}
