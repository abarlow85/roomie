//
//  RoomSelectionViewController.swift
//  Roomie
//
//  Created by Alec Barlow on 5/17/16.
//  Copyright © 2016 Alec Barlow. All rights reserved.
//

import UIKit

class RoomSelectionViewController: UITableViewController {
    
    @IBOutlet weak var roomSearchTextField: UITextField!

    
    let prefs = NSUserDefaults.standardUserDefaults()
    var rooms = NSMutableDictionary()
    
    override func viewDidLoad() {
        print("got to room page")
        print(prefs.valueForKey("currentUser")!)
        super.viewDidLoad()
    }

    func showAllRooms(){
        RoomModel.getRooms(){
            data, response, error in
            do{
                if(data != nil){
                    if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSMutableDictionary {
                        print(jsonResult)
                        self.rooms = jsonResult
                        print(self.rooms)
                        dispatch_async(dispatch_get_main_queue(), {
                            self.tableView.reloadData()
                        })
                    }
                }
                
            } catch {
                print("Something went wrong")
            }
        }
    }
    
    
    
}


