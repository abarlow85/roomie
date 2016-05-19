//
//  TaskViewController.swift
//  Roomie
//
//  Created by Alec Barlow on 5/17/16.
//  Copyright © 2016 Alec Barlow. All rights reserved.
//

import UIKit

class TaskViewController: UITableViewController, BackButtonDelegate {
    let prefs = NSUserDefaults.standardUserDefaults()
    let dateFormatter = NSDateFormatter()
    var roomTasks = [NSDictionary]()
    var roomUsers = [NSDictionary]()
    
    
    @IBOutlet var taskTableView: UITableView!

    
    override func viewDidLoad() {
//        print("taskView")
        let prefs = NSUserDefaults.standardUserDefaults()
        var room = prefs.stringForKey("currentRoom")!
        taskTableView.dataSource = self
        TaskModel.getTasksForRoom(room) {
            data, response, error in
            do {
                if let room = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSMutableDictionary {
//                    print("room information:")
//                    print(room)
                    let tasks = room["tasks"] as! NSArray
                    for task in tasks{
                        var newTask = task as! NSMutableDictionary
                        self.update(&newTask)
//                        print(newTask)
                        self.roomTasks.append(newTask)
                    }
                    let users = room["users"] as! NSArray
                    for user in users {
                        let newUser = user as! NSDictionary
                        self.roomUsers.append(newUser)
                    }
                    dispatch_async(dispatch_get_main_queue(), {
                        self.tableView.reloadData()
                    })
                }
            } catch {
                print("Something went wrong")
            }
        }
        super.viewDidLoad()
        var _ = NSTimer(timeInterval: 1.0, target: self, selector: #selector(UITableViewController.viewDidLoad), userInfo: nil, repeats: true)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        print(roomUsers)
        if segue.identifier == "taskSegue" {
//            let controller = segue.destinationViewController as! TaskDetailsViewController
            let barViewController = segue.destinationViewController as! UITabBarController
            let navController = barViewController.viewControllers![0] as! UINavigationController
            let controller = navController.topViewController as! TaskDetailsViewController
            controller.backButtonDelegate = self
            if let indexPath = taskTableView.indexPathForCell(sender as! UITableViewCell) {
//                print(roomTasks[indexPath.row]["_id"])
                let id = roomTasks[indexPath.row]["_id"] as! String
                controller.taskdetails = id
            }
        }
        if segue.identifier == "newTaskSegue" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! newTaskViewController
            controller.userArray = roomUsers
//            print(roomUsers)
            controller.backButtonDelegate = self
        }
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomTasks.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = taskTableView.dequeueReusableCellWithIdentifier("TaskCell")
        if (cell != nil)
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle,
                                   reuseIdentifier: "TaskCell")
            cell?.accessoryType = UITableViewCellAccessoryType.DetailDisclosureButton
        }
        
        cell?.textLabel?.text = roomTasks[indexPath.row]["objective"] as! String
        let timeLeft = String(roomTasks[indexPath.row ]["timeLeft"]!)
        cell?.detailTextLabel?.text = timeLeft
        return cell!
    }
    
    func update(inout newTask: NSMutableDictionary) {
        let now = NSDate()
        let dueDateString = newTask["expiration_date"] as! String
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dueDate = self.dateFormatter.dateFromString(dueDateString)!
        var timeLeft = Int(dueDate.timeIntervalSinceDate(now))
        let days = timeLeft / (60*60*24)
        timeLeft -= (days*60*60*24)
        let hours = timeLeft / (60*60)
        timeLeft -= (hours*60*60)
        let minutes = timeLeft / (60)
        timeLeft -= (minutes*60)
        print("days: \(days)")
        print("hours: \(hours)")
        print("minutes: \(minutes)")
        var timeLeftString = ""
        if days > 0 {
            timeLeftString += "\(days) days "
        }
        if hours > 0 {
            timeLeftString += "\(hours) hours "
        }
        if minutes >= 0 {
            timeLeftString += "\(minutes) minutes "
        }
        if timeLeft <= 0 {
            timeLeftString = "Task not completed"
        } else {
            timeLeftString += "left"
        }
        
        newTask["timeLeft"] = timeLeftString
        
//        print(timeLeft)
        
        
        
    }
    
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("taskSegue", sender: taskTableView.cellForRowAtIndexPath(indexPath))
    }
    
    func backButtonPressedFrom(controller: UITableViewController){
        dismissViewControllerAnimated(true, completion: nil)
    }
    func back2ButtonPressedFrom(controller: UIViewController){
        dismissViewControllerAnimated(true, completion: nil)
    }
    


}

