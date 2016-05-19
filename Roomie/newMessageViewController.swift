//
//  newMessageViewController.swift
//  Roomie
//
//  Created by Gabe Ratcliff on 5/18/16.
//  Copyright © 2016 Alec Barlow. All rights reserved.
//

import UIKit
class newMessageViewController: UIViewController{
    let prefs = NSUserDefaults.standardUserDefaults()
    weak var backButtonDelegate: BackButtonDelegate?
    @IBOutlet weak var commentTextField: UITextField!
    
    @IBAction func backButtonPressed(sender: UIBarButtonItem) {
        backButtonDelegate?.back2ButtonPressedFrom(self)
    }
    @IBAction func submitButtonPressed(sender: UIButton) {
        var messageData = NSMutableDictionary()
        messageData["content"] = commentTextField.text!
        messageData["_room"] =  prefs.stringForKey("currentRoom")
        messageData["_user"] = prefs.stringForKey("currentUser")
        messageData["_task"] = prefs.stringForKey("currentTaskView")
//        print(messageData)
        MessageModel.addMessage(messageData) {
            data, response, error in
            do {
//                if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSMutableDictionary {
//                    print(jsonResult)
//                    dispatch_async(dispatch_get_main_queue(), {
//                        self.performSegueWithIdentifier("MessageAddedSegue", sender: self)
                
//                    })
//                }
            
            }catch {
                print(data)
                print(response)
                print(error)
            }

        }
    }
    
    override func viewDidLoad() {

        super.viewDidLoad()
    }

}
