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
  

    @IBAction func backButtonPressed(sender: UIBarButtonItem) {
          backButtonDelegate?.back2ButtonPressedFrom(self)
        print("Back")
    }
    @IBAction func newTaskSubmitted(sender: UIButton) {
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
                print("Success")
                
            } catch {
                print("Something went wrong")
            }
        }

    }
       override func viewDidLoad() {
        self.userTableView.allowsMultipleSelection = true
        
        var room = prefs.stringForKey("currentRoom")
        userTableView.dataSource = self
        userTableView.delegate = self
        super.viewDidLoad()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArray!.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = userTableView.dequeueReusableCellWithIdentifier("userChoiceCell")!
        cell.textLabel?.text =  userArray![indexPath.row]["name"] as! String
        cell.selectionStyle = .None
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
    
    
 
    
    
}

