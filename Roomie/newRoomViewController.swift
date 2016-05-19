//
//  newRoomViewController.swift
//  Roomie
//
//  Created by Nigel Koh on 5/19/16.
//  Copyright © 2016 Alec Barlow. All rights reserved.
//

import UIKit

class newRoomViewController: UIViewController {
    weak var backButtonDelegate: BackButtonDelegate?
    let prefs = NSUserDefaults.standardUserDefaults()
    let dateFormatter = NSDateFormatter()
    var userArray: NSArray?
    var responsibleUsers = [String]()
    
    @IBOutlet weak var newRoomName: UITextField!
    @IBOutlet weak var newRoomCategory: UITextField!

    @IBAction func backButtonPressed(sender: UIBarButtonItem) {
        backButtonDelegate?.back2ButtonPressedFrom(self)
        print("Back")
    }
    
    @IBAction func newRoomSubmitted(sender: UIButton) {
        print("submit button was clicked")
        var roomData = NSMutableDictionary()
        roomData["name"] = newRoomName.text!
        roomData["category"] = newRoomCategory.text!
        roomData["user"] = prefs.stringForKey("currentUser")! as String
        RoomModel.addRoom(roomData) {
            data, response, error in
            do {
                //                print(response)
                if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSMutableDictionary {
                    print(jsonResult)
                    let roomId = jsonResult["_id"]
                    self.prefs.setValue(roomId, forKey: "currentRoom")
                    print("roomId: \(jsonResult["_id"])")
                    dispatch_async(dispatch_get_main_queue(), {
                        self.performSegueWithIdentifier("roomAddedSegue", sender: jsonResult)
                    })
                }
            }catch {
                print(data)
                print(response)
                print(error)
            }
        }

    }
//    @IBAction func newRoomSubmitted(sender: UIBarButtonItem) {
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

