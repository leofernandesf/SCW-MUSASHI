//
//  HomeViewController.swift
//  SCW-MUSASHI
//
//  Created by leo on 09/11/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var ptSearch: UIButton!
    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var myCollection: UICollectionView!
    var chamadas : [[String: Any]]?
    var consultas: [[String: Any]]?
    var mostrarInformacoes: [[String: Any]]?
    var envia: [String: Any]!
    let defaults = UserDefaults.standard
    var cont = 2
    var index = IndexPath(item: 0, section: 0)
    let titulos = ["Consultas", "Chamados", "Aprovados"]
    override func viewDidLoad() {
        super.viewDidLoad()
        let image = Layout.sizeImage(width: 20, height: 20, image: #imageLiteral(resourceName: "ic_search"))
        ptSearch.setImage(image, for: .normal)
        if let contMenu = defaults.object(forKey: "contMenu") as? Int {
            print(contMenu)
            cont = contMenu
        }
        self.myTable.tableFooterView = UIView(frame: .zero)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Helper.GET(urlString: "http://191.168.20.202/scw/ws_issue/show") { (recebeJson) in
            //            self.chamadas = chamadas
            //            self.consultas = consultas
            //            print("chamadas: \(self.chamadas?.count) - consultas: \(self.consultas?.count)")
            //            if self.index.item == 0 {
            //                self.mostrarInformacoes = self.chamadas
            //            } else {
            //                self.mostrarInformacoes = self.consultas
            //            }
            //            DispatchQueue.main.async {
            //                self.myTable.reloadData()
            //            }
            self.separaChamadas(json: recebeJson)
            
        }
        
        
        myCollection.dataSource = self
        myCollection.delegate = self
        
        
        myCollection.selectItem(at: index, animated: true, scrollPosition: .left)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        
    }
    
    func separaChamadas(json: Dictionary<String, AnyObject>) {
        let x = json["data"] as! [[String: Any]]
        chamadas = [[String: Any]]()
        consultas = [[String: Any]]()
        for y in x {
            if let query = y["query"] as? Int {
                if query == 1 {
                    self.chamadas?.append(y)
                } else {
                    self.consultas?.append(y)
                }
            }
        }
        print("chamadas: \(self.chamadas?.count) - consultas: \(self.consultas?.count)")
        if self.index.item == 0 {
            self.mostrarInformacoes = self.chamadas
        } else if self.index.item == 1{
            self.mostrarInformacoes = self.consultas
        }
        DispatchQueue.main.async {
            self.myTable.reloadData()
        }
    }
    
    @IBAction func opcoes(_ sender: AnyObject) {
        menuOpcoes()
    }
    
    
    func menuOpcoes() {
        let alert: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let idioma =  UIAlertAction(title: "Idioma", style: .default) { UIAlertAction in
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "chooseLanguage") as! ChooseLanguageViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        let sobre =  UIAlertAction(title: "Sobre", style: .default) { UIAlertAction in
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "sobre") as! SobreViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        let logOut =  UIAlertAction(title: "Logout", style: .default) { UIAlertAction in
            self.defaults.set(0, forKey: "logado")
            _ = self.navigationController?.popToRootViewController(animated: false)
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
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCellCollectionViewCell
        cell.lbTitle.text = titulos[indexPath.item]
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
        }
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
