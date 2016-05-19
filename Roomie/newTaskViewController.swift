//
//  newTaskViewController.swift
//  Roomie
//
//  Created by Gabe Ratcliff on 5/18/16.
//  Copyright © 2016 Alec Barlow. All rights reserved.
//

import UIKit

class newTaskViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    weak var backButtonDelegate: BackButtonDelegate?
    let prefs = NSUserDefaults.standardUserDefaults()
    let dateFormatter = NSDateFormatter()
    var userArray: NSArray?
    var responsibleUsers = [String]()

    @IBOutlet weak var newTaskText: UITextField!
    @IBOutlet weak var newTaskDate: UIDatePicker!
    @IBOutlet weak var userTableView: UITableView!
    @IBOutlet weak var errorLabelText: UILabel!
  

    @IBAction func backButtonPressed(sender: UIBarButtonItem) {
          backButtonDelegate?.back2ButtonPressedFrom(self)
        print("Back")
    }
    @IBAction func newTaskSubmitted(sender: UIButton) {
        
        if newTaskText.text!.isEmpty {
            errorLabelText.text = "Task field is blank"
            return
        }
        if newTaskDate.date.timeIntervalSinceDate(NSDate()) <= 0 {
            errorLabelText.text = "Due date cannot be in the past"
            return
        }
        if responsibleUsers.count == 0 {
            errorLabelText.text = "No roomie was selected"
            return
        }

        
        var taskData = NSMutableDictionary()
        
        print(newTaskText.text)
        print(newTaskDate.date)
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let fromDate = dateFormatter.stringFromDate(newTaskDate.date)
        
        taskData["objective"] = newTaskText.text!
        taskData["expiration_date"] = fromDate
        taskData["users"] = responsibleUsers
        taskData["_room"] = prefs.stringForKey("currentRoom")!
        print (taskData)
        TaskModel.addTask(taskData) {
            data, response, error in
            do {
                //                print(response)
                if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSMutableDictionary {
                    print(jsonResult)
                    dispatch_async(dispatch_get_main_queue(), {
                        self.performSegueWithIdentifier("TaskAddedSegue", sender: jsonResult)
                    })
                    
                }
                
            }catch {
                print(data)
                print(response)
                print(error)
            }


        }

    }
       override func viewDidLoad() {
        self.userTableView.allowsMultipleSelection = true
        
        var room = prefs.stringForKey("currentRoom")
        userTableView.dataSource = self
        userTableView.delegate = self
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArray!.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = userTableView.dequeueReusableCellWithIdentifier("userChoiceCell")!
        cell.textLabel?.text =  userArray![indexPath.row]["name"] as! String
        cell.selectionStyle = .None
        cell.backgroundColor = UIColor(red:197/255.0, green:224/255.0, blue:216/255.0, alpha: 1.0)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        userTableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.Checkmark
        let userId = userArray![indexPath.row]["_id"] as! String
        responsibleUsers.append(userId)
    }
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        userTableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.None
        let userId = userArray![indexPath.row]["_id"] as! String
        let userIndex = responsibleUsers.indexOf(userId)
        responsibleUsers.removeAtIndex(userIndex!)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
 
    
    
}

