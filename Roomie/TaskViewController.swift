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
    var roomTasks = [NSMutableDictionary]()
    var roomUsers = [NSDictionary]()
    

    @IBOutlet var taskTableView: UITableView!

    
    override func viewDidLoad() {
//        print("taskView")
        let prefs = NSUserDefaults.standardUserDefaults()
        var room = prefs.stringForKey("currentRoom")!
        print("you are in room with id: \(room)")
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
//                        self.update(&newTask)
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
                        self.update()
                        print(self.roomTasks)
                    })
                }
            } catch {
                print("Something went wrong")
            }
        }
//        tableView.backgroundColor = UIColor.redColor()
        super.viewDidLoad()
        
        
        
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
            cell!.selectionStyle = .None
            cell?.accessoryType = UITableViewCellAccessoryType.DetailDisclosureButton
            cell!.backgroundColor = UIColor(red:197/255.0, green:224/255.0, blue:216/255.0, alpha: 1.0)
        }
        
        let objective = roomTasks[indexPath.row]["objective"] as! String
        var userString = ""
        let users = roomTasks[indexPath.row]["users"] as! NSArray
        for idx in 0..<users.count {
            let user = users[idx]["name"] as! String
            if users.count < 2 {
                userString += user
            } else if idx < users.count - 2 {
                userString += "\(user), "
            } else if idx == users.count - 2 {
                userString += "\(user) and "
            } else {
                userString += "\(user)"
            }
            
        }
        cell?.textLabel?.text = "\(objective)"
        var completed = self.roomTasks[indexPath.row]["completed"]! as! String
        print(completed)
        if completed == "notcompleted" {
            cell?.textLabel?.text = roomTasks[indexPath.row]["objective"] as! String
        } else {
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: roomTasks[indexPath.row]["objective"] as! String)
            attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
            cell?.textLabel?.attributedText = attributeString;
        
        }
        
        let timeLeft = String(roomTasks[indexPath.row ]["timeLeft"]!)
        cell?.detailTextLabel?.text = "\(timeLeft): \(userString)"
        return cell!
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .Delete {
//            let task = roomTasks[indexPath.row]
//            TaskModel.removeTask(task) {
//                data, response, error in
//                do {
//                    if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSMutableDictionary {
//                        print(jsonResult)
//                        self.roomTasks.removeAtIndex(indexPath.row)
//                        dispatch_async(dispatch_get_main_queue(), {
//                            self.tableView.reloadData()
//                        })
//                    }
//
//                } catch {
//                    print("Something went wrong")
//                }
////                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//            }
//        }
//        // remove the mission at indexPath
//        // reload the table view
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .Destructive, title: "Delete") { (action, indexPath) in
            // delete item at indexPath
            let task = self.roomTasks[indexPath.row]
            TaskModel.removeTask(task) {
                data, response, error in
                do {
                    if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSMutableDictionary {
                        print(jsonResult)
                        self.roomTasks.removeAtIndex(indexPath.row)
                        dispatch_async(dispatch_get_main_queue(), {
                            self.tableView.reloadData()
                        })
                    }
                    
                } catch {
                    print("Something went wrong")
                }
                //                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }

        }
        
        let share = UITableViewRowAction(style: .Normal, title: "Completed") { (action, indexPath) in
            // complete item at indexPath
            let task = self.roomTasks[indexPath.row]
            TaskModel.updateTaskToCompleted(task){
                data, response, error in
                do {
                    if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSMutableDictionary {
                        print(jsonResult)
                        self.roomTasks[indexPath.row]["completed"] = "completed"
                        dispatch_async(dispatch_get_main_queue(), {
                            self.tableView.reloadData()
                        })
                    }
                    
                } catch {
                    print("Something went wrong")
                }
            }
            
        }
        
        share.backgroundColor = UIColor.blueColor()
        return [delete, share]
    }
    
    
    func update() {
        let now = NSDate()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        for newTask in roomTasks {
            let dueDateString = newTask["expiration_date"] as! String
            let completed = newTask["completed"] as! String
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
                timeLeftString += "\(days)d "
            }
            if hours > 0 {
                timeLeftString += "\(hours)h "
            }
            if minutes >= 0 {
                timeLeftString += "\(minutes)m "
            }
            if timeLeft <= 0 && completed == "notcompleted" {
                timeLeftString = "Task not completed"
            }
            if timeLeft <= 0 && completed == "completed" {
                timeLeftString = "Task completed"
            } else {
                timeLeftString += "left"
            }
            
            newTask["timeLeft"] = timeLeftString
            
        }
        taskTableView.reloadData()
        
//        print(timeLeft)
    }
    
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("taskSegue", sender: taskTableView.cellForRowAtIndexPath(indexPath))
    }
    
    func backButtonPressedFrom(controller: UITableViewController){
        dismissViewControllerAnimated(true, completion: self.update)
    }
    func back2ButtonPressedFrom(controller: UIViewController){
        dismissViewControllerAnimated(true, completion: self.update)
    }


}

