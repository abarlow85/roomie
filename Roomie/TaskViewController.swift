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
    var roomTasks = [NSDictionary]()
    var roomUsers = [NSDictionary]()
    
    @IBOutlet var taskTableView: UITableView!
    
    override func viewDidLoad() {
        print("taskView")
        let prefs = NSUserDefaults.standardUserDefaults()
        var room = prefs.stringForKey("currentRoom")!
        taskTableView.dataSource = self
        TaskModel.getTasksForRoom(room) {
            data, response, error in
            do {
                if let room = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSMutableDictionary {
                    print("room information:")
//                    print(room)
                    let tasks = room["tasks"] as! NSArray
                    for task in tasks{
                        let newTask = task as! NSDictionary
//                        print(newTask)
                        self.roomTasks.append(newTask)
                    }
                    print (self.roomTasks)
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
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print(roomUsers)
        if segue.identifier == "taskSegue" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! TaskDetailsViewController
            controller.backButtonDelegate = self
            if let indexPath = taskTableView.indexPathForCell(sender as! UITableViewCell) {
                controller.taskdetails = roomTasks[indexPath]
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
        cell?.detailTextLabel?.text = roomTasks[indexPath.row ]["expiration_date"] as! String
        return cell!
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

