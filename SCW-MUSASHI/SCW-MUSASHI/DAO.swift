//
//  DAO.swift
//  SCW-MUSASHI
//
//  Created by leo on 18/11/16.
//  Copyright © 2016 br.com.tap4mobile. All rights reserved.
//

import UIKit
import CoreData

class DAO: NSObject {
    
    static func saveLanguage(linguagemEscolhida: [String]) {
        let keys = ["aceitar", "close", "comentar", "confirmar", "date", "done", "encaminhar", "exit", "finish", "issue", "nao", "operador", "popUp", "queries", "reject", "sector", "sim", "sobre", "ttlLanguage", "aprovado"]
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newLanguage = NSEntityDescription.insertNewObject(forEntityName: "Linguagem", into: context)
        
        
        for i in 0..<linguagemEscolhida.count {
            newLanguage.setValue(linguagemEscolhida[i], forKey: keys[i])
        }
        
        
        do {
            
            try context.save()
            print("SALVOU")
            
        } catch {
            print("error quando foi salvar no core")
        }
    }
    
    
    
    static func selectedLanguage(language: [[String]], i: Int) {
        var palavras = [String]()
        
        palavras.append(language[0][i])
        palavras.append(language[1][i])
        palavras.append(language[2][i])
        palavras.append(language[3][i])
        palavras.append(language[12][i])
        palavras.append(language[4][i])
        palavras.append(language[13][i])
        palavras.append(language[17][i])
        palavras.append(language[5][i])
        palavras.append(language[14][i])
        palavras.append(language[6][i])
        palavras.append(language[18][i])
        palavras.append(language[21][i])
        palavras.append(language[19][i])
        palavras.append(language[7][i])
        palavras.append(language[20][i])
        palavras.append(language[8][i])
        palavras.append(language[15][i])
        palavras.append(language[16][i])
        palavras.append(language[10][i])
        print(palavras)
        DAO.saveLanguage(linguagemEscolhida: palavras)
    }
    
    static func excluir() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Linguagem")
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        do {
            let results = try context.execute(request)
            print(results)
            
        } catch {
            print("erro")
        }
        
    }
    static func LinguagemSalvas(str: String) -> String{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Linguagem")
        var retorno = String()
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            print(results.count)
            
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    if let aceitar = result.value(forKey: str) as? String {
                        retorno = aceitar
                    }
                }
            }
        } catch {
            print("erro")
        }
        return retorno
    }

}
