//
//  RoomModel.swift
//  Roomie
//
//  Created by Nigel Koh on 5/17/16.
//  Copyright © 2016 Alec Barlow. All rights reserved.
//

import Foundation

class RoomModel {
    
    let prefs = NSUserDefaults.standardUserDefaults()
    
    static func getRooms(completionHandler: (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void) {
        let url = NSURL(string: "http://localhost:8000/rooms")
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!, completionHandler: completionHandler)
        task.resume()
    }
    
//    static func createRoom(roomData: NSMutableDictionary, completionHandler: (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void ) {
//        
//        if let url = NSURL(string: "http://localhost:8000/rooms/create") {
//            let request = NSMutableURLRequest(URL: url)
//            request.HTTPMethod = "POST"
//            let bodyData = "{\"email\":\"\(roomData["email"] as! String)\", \"password\":\"\(roomData["password"] as! String)\"}"
//            request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding)
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            let session = NSURLSession.sharedSession()
//            let task = session.dataTaskWithRequest(request, completionHandler: completionHandler)
//            task.resume()
//            
//        }
//        
//    }
    
}