//
//  MessageModel.swift
//  Roomie
//
//  Created by Gabe Ratcliff on 5/18/16.
//  Copyright © 2016 Alec Barlow. All rights reserved.
//
import Foundation
class MessageModel {
    static func addMessage(messageData:NSDictionary, completionHandler: (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void){
        do {
            print(messageData)
            let jsonData = try NSJSONSerialization.dataWithJSONObject(messageData, options: NSJSONWritingOptions.PrettyPrinted)
            let jsonString = NSString(data: jsonData, encoding: NSUTF8StringEncoding) as! String
            print(jsonString)
            if let url = NSURL(string: "http://52.27.27.251/messages/create") {
                let request = NSMutableURLRequest(URL: url)
                request.HTTPMethod = "POST"
                request.HTTPBody = jsonString.dataUsingEncoding(NSUTF8StringEncoding)
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                let session = NSURLSession.sharedSession()
                let task = session.dataTaskWithRequest(request, completionHandler: completionHandler)
                task.resume()
            }
        } catch let error as NSError {
            print(error)
        }
    }
}
