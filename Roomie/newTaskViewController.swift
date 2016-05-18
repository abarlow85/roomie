//
//  newTaskViewController.swift
//  Roomie
//
//  Created by Gabe Ratcliff on 5/18/16.
//  Copyright © 2016 Alec Barlow. All rights reserved.
//

import UIKit

class newTaskViewController: UIViewController {
    weak var backButtonDelegate: BackButtonDelegate?
    let prefs = NSUserDefaults.standardUserDefaults()

    @IBOutlet weak var newTaskText: UITextField!
    @IBAction func backButtonPressed(sender: UIBarButtonItem) {
          backButtonDelegate?.back2ButtonPressedFrom(self)
        print("Back")
    }
    @IBAction func newTaskSubmitted(sender: UIButton) {
        var taskData = NSMutableDictionary()
        print(newTaskText.text)
        taskData["objective"] = newTaskText.text!
        taskData["expiration_date"] = NSDate()
//        TaskModel.addTask(newTaskText.text!) {
//            data, response, error in
//            do {
//                
//            } catch {
//                print("Something went wrong")
//            }
//        }

    }
       override func viewDidLoad() {
        var room = prefs.stringForKey("currentRoom")
//        TaskModel.getTasksForRoom(room!) {
//            data, response, error in
//            do {
//                if let tasks = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSArray {
//                    
//                }
//            } catch {
//                print("Something went wrong")
//            }
//        }

        super.viewDidLoad()
    }
    

    
    
    
}

