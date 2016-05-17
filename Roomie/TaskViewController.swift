//
//  TaskViewController.swift
//  Roomie
//
//  Created by Alec Barlow on 5/17/16.
//  Copyright © 2016 Alec Barlow. All rights reserved.
//

import UIKit

class TaskViewController: UITableViewController, BackButtonDelegate {

    override func viewDidLoad() {
        TaskModel.getTasksForRoom() {
            data, response, error in
            do {
                if let tasks = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSArray {
                    for task in tasks{
                        print (task)
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
//        if segue.identifier == "LogoutSegue"{
//            let navigationConroller = segue.destinationViewController as! UINavigationController
//            let controller = navigationConroller.topViewController as! LoginViewController
//        }
    }

    
    func backButtonPressedFrom(controller: UITableViewController){
        dismissViewControllerAnimated(true, completion: nil)
    }
    


}

