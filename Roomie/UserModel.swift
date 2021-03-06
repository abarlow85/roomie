//
//  UserModel.swift
//  Roomie
//
//  Created by Alec Barlow on 5/17/16.
//  Copyright © 2016 Alec Barlow. All rights reserved.
//

import Foundation

class UserModel {
    
    static func registerUser(userData: NSMutableDictionary, completionHandler: (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void ) {
        
        print(userData);
        if let url = NSURL(string: "http://52.27.27.251/register") {
            let request = NSMutableURLRequest(URL: url)
            
            request.HTTPMethod = "POST"
            let bodyData = "{\"name\":\"\(userData["name"] as! String)\", \"email\":\"\(userData["email"] as! String)\", \"password\":\"\(userData["password"] as! String)\"}"
            request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithRequest(request, completionHandler: completionHandler)
            task.resume()
           
        }
        
    }
    
    static func loginUser(userData: NSMutableDictionary, completionHandler: (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void ) {
        
        if let url = NSURL(string: "http://52.27.27.251/login") {
            let request = NSMutableURLRequest(URL: url)
            
            request.HTTPMethod = "POST"
            let bodyData = "{\"email\":\"\(userData["email"] as! String)\", \"password\":\"\(userData["password"] as! String)\"}"
            request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithRequest(request, completionHandler: completionHandler)
            task.resume()
            
        }
        
    }
    
}
