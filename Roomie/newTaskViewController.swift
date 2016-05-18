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
    @IBAction func backButtonPressed(sender: UIBarButtonItem) {
          backButtonDelegate?.back2ButtonPressedFrom(self)
        print("Back")
    }
       override func viewDidLoad() {
//        TaskModel.addTask(task) {
//            data, response, error in
//            do {
//                if let tasks = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSArray {
//                    for task in tasks{
//                        let newTask = task as! NSDictionary
//                        print(newTask)
//                        self.roomTasks.append(newTask)
//                    }
//                    self.tableView.reloadData()
//                }
//            } catch {
//                print("Something went wrong")
//            }
//        }
        super.viewDidLoad()
    }
    

    
    
    
}

