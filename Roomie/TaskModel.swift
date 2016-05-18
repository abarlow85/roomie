//
//  TaskModel.swift
//  Roomie
//
//  Created by Gabe Ratcliff on 5/17/16.
//  Copyright © 2016 Alec Barlow. All rights reserved.
//

import Foundation
class TaskModel {
    static func getTasksForRoom(room:String, completionHandler: (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void){
        let url = NSURL (string: "http://localhost:8000/rooms/" + room)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!, completionHandler: completionHandler)
        task.resume()
    }
    static func addTask(taskData:NSDictionary, completionHandler: (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void){
        do {
            let jsonData = try NSJSONSerialization.dataWithJSONObject(taskData, options: NSJSONWritingOptions.PrettyPrinted) 
            do {
                let decoded = try NSJSONSerialization.JSONObjectWithData(jsonData, options: []) as? [String: String]
                let url = NSURL (string: "http://localhost:8000/tasks/create")
                let request = NSMutableURLRequest(URL: url!)
                request.HTTPMethod = "POST"
                request.HTTPBody = decoded.dataUsingEncoding(NSUTF8StringEncoding)
                let session = NSURLSession.sharedSession()
                let task = session.dataTaskWithURL(url!, completionHandler: completionHandler)
                task.resume()

            }
            catch let error as NSError {
                print (error)
            }
        } catch let error as NSError {
            print(error)
            }
    }
}
