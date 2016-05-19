//
//  MessageViewController.swift
//  Roomie
//
//  Created by Gabe Ratcliff on 5/17/16.
//  Copyright © 2016 Alec Barlow. All rights reserved.
//


import UIKit

class MessageViewController: UITableViewController, BackButtonDelegate {

    @IBOutlet var messageTableView: UITableView!
    var messages = [NSDictionary]()
    let prefs = NSUserDefaults.standardUserDefaults()
    var taskdetails: String?
    
    override func viewDidLoad() {
        messageTableView.dataSource = self
        taskdetails =  prefs.stringForKey("currentTaskView")
        TaskModel.getSingleTask(taskdetails!) {
            data, response, error in
            do{
                if let task = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSMutableDictionary {
                    print(task)
                    let newMessages = task["messages"] as! NSArray
                    print ("Messages in message table: ")
                    print (newMessages)
                    for message in newMessages {
                        print(message)
                        let newMessage = message as! NSDictionary
                        self.messages.append(newMessage)
                    }
                    dispatch_async(dispatch_get_main_queue(), {
                        self.messageTableView.reloadData()
                    })
                }
            }catch {
                print("Error")
            }
        }
        super.viewDidLoad()
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "newMessageSegue" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! newMessageViewController
            controller.backButtonDelegate = self
        }
    }


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = messageTableView.dequeueReusableCellWithIdentifier("MessageCell")
        if (cell != nil)
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle,
                                   reuseIdentifier: "TaskCell")
        }

        cell?.textLabel?.text = messages[indexPath.row]["content"] as! String
        cell?.detailTextLabel?.text = messages[indexPath.row ]["_user"]!["name"] as! String
        return cell!
    }
    func back2ButtonPressedFrom(controller: UIViewController){
        dismissViewControllerAnimated(true, completion: nil)
    }
    func backButtonPressedFrom(controller: UITableViewController){
        dismissViewControllerAnimated(true, completion: nil)
    }

  
    
}

