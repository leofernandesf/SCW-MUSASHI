//
//  MusashiService.swift
//  SCW-MUSASHI
//
//  Created by leo on 28/07/17.
//  Copyright © 2017 br.com.tap4mobile. All rights reserved.
//

import Foundation
import UIKit

class MusashiService {
    
    static var IP: String {
        return UserDefaults.standard.object(forKey: "IP") as! String
    }
    
    enum UrlService: String {
        case login              = "/scw/ws_mobile/login/"
        case labels             = "/scw/ws_config/get_labels"
        case home               = "/scw/ws_issue/show"
        case status             = "/scw/ws_mobile/set_status/"
        case categories         = "/scw/ws_toten/get_issues_categories"
        case assignedUser       = "/scw/ws_issue/get_assigned_users/"
        case comments           = "/scw/ws_mobile/get_comments/"
        case changeCategory     = "/scw/ws_issue/change_category/"
        case setAssignedUser    = "/scw/ws_issue/set_assigned_users/"
        case newComment         = "/scw/ws_issue/new_comment/"
    }
    
    static func POST(urlType: UrlService, postString: [String : Any],id: String = "",completion: @escaping (_ prifileID: Dictionary<String, AnyObject>)-> Void) {
        
        var url = urlType.rawValue
        
        if id != "" {
            url += id
        }
        
        
        let urlString = getFullUrlWith(jobType: url)
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.httpBody = postString.data(using: String.Encoding.utf8)
        do {
            let json = try JSONSerialization.data(withJSONObject: postString, options: [])
            request.httpBody = json
        } catch let jsonError {
            print(jsonError)
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
                
            } else {
                let responseString = String(data: data, encoding: .utf8)
                print(responseString)
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String, AnyObject>
                    
                    completion(json)
                    
                } catch let jsonError {
                    print(jsonError)
                }
            }
            
        }
        task.resume()
    }
    
    
    static func GET(urlType: UrlService,id: String = "",completion: @escaping (_ chamadas: Dictionary<String, AnyObject> )-> Void) {
        
        var url = urlType.rawValue
        
        if id != "" {
            url += id
        }
        let urlString = getFullUrlWith(jobType: url)
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
                
            }else {
                
                //                let responseString = String(data: data, encoding: .utf8)
                //                print(responseString!)
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String, AnyObject>
                    print(json)
                    completion(json)

                } catch let jsonError {
                    print(jsonError)
                }
            }
            
        }
        task.resume()
        
    }
    
    
    static private func getFullUrlWith(jobType: String) -> String {
        return IP.appending(jobType)
    }
}
