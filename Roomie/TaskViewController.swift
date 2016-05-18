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
    override func viewDidLoad() {
        print(prefs.valueForKey("currentRoom"))
        var room = prefs.stringForKey("currentRoom")

        TaskModel.getTasksForRoom(room!) {
            data, response, error in
            do {
                if let tasks = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSArray {
                    for task in tasks{
                        let newTask = task as! NSDictionary
                        print(newTask)
                        self.roomTasks.append(newTask)
                    }
                    self.tableView.reloadData()
                }
            } catch {
                print("Something went wrong")
            }
        }
        super.viewDidLoad()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "taskSegue" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! MessageViewController
            controller.backButtonDelegate = self
        }
        if segue.identifier == "newTaskSegue" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! newTaskViewController
            controller.backButtonDelegate = self
        }
    }

    
    func backButtonPressedFrom(controller: UITableViewController){
        dismissViewControllerAnimated(true, completion: nil)
    }
    func back2ButtonPressedFrom(controller: UIViewController){
        dismissViewControllerAnimated(true, completion: nil)
    }
    


}

