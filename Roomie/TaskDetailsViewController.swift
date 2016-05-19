//
//  TaskDetailsViewController.swift
//  Roomie
//
//  Created by Nigel Koh on 5/18/16.
//  Copyright © 2016 Alec Barlow. All rights reserved.
//

import UIKit

class TaskDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, BackButtonDelegate {
    
    @IBOutlet weak var userTableView: UITableView!
    weak var backButtonDelegate: BackButtonDelegate?
    var taskdetails: NSDictionary?
    var users: [NSDictionary]?
    
    
    override func viewDidLoad() {
        userTableView.dataSource = self
        userTableView.delegate = self
        let users = taskdetails!["users"] as! NSArray
        for user in users {
            let newUser = user as! NSDictionary
        }
        
        super.viewDidLoad()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskdetails!.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = userTableView.dequeueReusableCellWithIdentifier("userChoiceCell")!
        cell.textLabel?.text =  taskdetails![indexPath.row]!["name"] as! String
        cell.selectionStyle = .None
        return cell
    }
    
    func backButtonPressedFrom(controller: UITableViewController){
        dismissViewControllerAnimated(true, completion: nil)
    }
    func back2ButtonPressedFrom(controller: UIViewController){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        userTableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.Checkmark
//        let userId = userArray![indexPath.row]["_id"] as! String
//        responsibleUsers.append(userId)
//    }
//    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
//        userTableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.None
//        let userId = userArray![indexPath.row]["_id"] as! String
//        let userIndex = responsibleUsers.indexOf(userId)
//        responsibleUsers.removeAtIndex(userIndex!)
//    }
    
    
    
    
}
