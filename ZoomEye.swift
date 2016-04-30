//
//  ZoomEye.swift
//  test
//
//  Created by Shaotuo Lee on 4/29/16.
//  Copyright © 2016 onepunch. All rights reserved.
//

import Foundation

class ZoomEye: NSObject {
    
    var username: String!
    var password: String!
    var access_token: String?
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    func Login(completionHandler: String -> Void) -> Void {
        
        // compose request
        let url = NSURL(string: "http://api.zoomeye.org/user/login")!
        let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        let loginInfo = [
            "username": username!,
            "password": password!
        ]
        let jsonData = try! NSJSONSerialization.dataWithJSONObject(loginInfo, options: NSJSONWritingOptions.PrettyPrinted)
        request.HTTPBody = jsonData
        
        // how to do with data arrived
        let handler: (NSData?, NSURLResponse?, NSError?) -> Void = {(data, response, error) in
            
            if let httpResponse = response as? NSHTTPURLResponse {
                switch httpResponse.statusCode {
                    
                case 200:
                    let token = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? [String: String]
                    self.access_token = token!["access_token"]
                    completionHandler(self.access_token!)
                    
                default:
                    print("error \(httpResponse.statusCode)")
                }
                
            }
        }
        
        // define and start session
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: handler)
        task.resume()
    }
    
    func ResourceInfo(completionHandler: (resourceInfo: [String: AnyObject]) -> Void) -> Void {
        
        self.Login {(access_token) in
            // compose request
            let url = NSURL(string: "http://api.zoomeye.org/resources-info")!
            let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "GET"
            
            let jwt = String("JWT")
            let token = String(access_token)
            let auth = NSString.localizedStringWithFormat("%@ %@", jwt, token) as String
            request.setValue(auth, forHTTPHeaderField: "Authorization")
            
            
            // how to do with data arrived
            let handler: (NSData?, NSURLResponse?, NSError?) -> Void = {(data, response, error) in
                
                if let httpResponse = response as? NSHTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200:
                        let info = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? [String: AnyObject]
                        completionHandler(resourceInfo: info!)
                        
                    default:
                        print("error \(httpResponse.statusCode)")
                    }
                    
                }
            }
            
            // define and start session
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: handler)
            task.resume()
        }
    }
    
    func SearchHost(query: String, page: Int, facets: String, completionHandler: (host: [String: AnyObject]) -> Void) -> Void {
        
        self.Login {(access_token) in
            // compose request
            let url = NSString.localizedStringWithFormat("http://api.zoomeye.org/host/search?query=%@&page=%d&facets=%@", query, page, facets) as String
            let request: NSMutableURLRequest = NSMutableURLRequest(URL: NSURL(string: url)!)
            request.HTTPMethod = "GET"
            
            let jwt = String("JWT")
            let token = String(access_token)
            let auth = NSString.localizedStringWithFormat("%@ %@", jwt, token) as String
            request.setValue(auth, forHTTPHeaderField: "Authorization")
            
            // how to do with data arrived
            let handler: (NSData?, NSURLResponse?, NSError?) -> Void = {(data, response, error) in
                
                if let httpResponse = response as? NSHTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200:
                        let host = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? [String: AnyObject]
                        completionHandler(host: host!)
                        
                    default:
                        print("error \(httpResponse.statusCode)")
                    }
                    
                }
            }
            
            // define and start session
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: handler)
            task.resume()
        }
    }
    
    func SearchWeb(query: String, page: Int, facets: String, completionHandler: (web: [String: AnyObject]) -> Void) -> Void {
        self.Login {(access_token) in
            // compose request
            let url = NSString.localizedStringWithFormat("http://api.zoomeye.org/web/search?query=%@&page=%d&facets=%@", query, page, facets) as String
            let request: NSMutableURLRequest = NSMutableURLRequest(URL: NSURL(string: url)!)
            request.HTTPMethod = "GET"
            
            let jwt = String("JWT")
            let token = String(access_token)
            let auth = NSString.localizedStringWithFormat("%@ %@", jwt, token) as String
            request.setValue(auth, forHTTPHeaderField: "Authorization")
            
            // how to do with data arrived
            let handler: (NSData?, NSURLResponse?, NSError?) -> Void = {(data, response, error) in
                
                if let httpResponse = response as? NSHTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200:
                        let web = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? [String: AnyObject]
                        completionHandler(web: web!)
                        
                    default:
                        print("error \(httpResponse.statusCode)")
                    }
                    
                }
            }
            
            // define and start session
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: handler)
            task.resume()
        }
    }
}