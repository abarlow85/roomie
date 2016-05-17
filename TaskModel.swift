//
//  TaskModel.swift
//  Roomie
//
//  Created by Gabe Ratcliff on 5/17/16.
//  Copyright © 2016 Alec Barlow. All rights reserved.
//

import Foundation
class TaskModel {
    static func getTasksForRoom(completionHandler: (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void){
        let url = NSURL (string: "http://localhost:8000/")
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!, completionHandler: completionHandler)
        task.resume()
    }
}