//
//  RoomSelectionViewController.swift
//  Roomie
//
//  Created by Alec Barlow on 5/17/16.
//  Copyright © 2016 Alec Barlow. All rights reserved.
//

import UIKit


extension RoomSelectionViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

class RoomSelectionViewController: UITableViewController {
    
    @IBOutlet weak var RoomSearchBar: UISearchBar!
    
//    var rooms = [
//        Room(category: "UC Berkeley", name: "123"),
//        Room(category: "UC Berkeley", name: "321"),
//        Room(category: "UC Berkeley", name: "541"),
//        Room(category: "UC Berkeley", name: "875"),
//        Room(category: "UC Berkeley", name: "122"),
//        Room(category: "UC Davis", name: "1"),
//        Room(category: "UC Davis", name: "2"),
//        Room(category: "Coding Dojo", name: "iOS")
//    ]
    var filteredRooms = [NSMutableDictionary]()
    
    let prefs = NSUserDefaults.standardUserDefaults()
    var rooms = [NSMutableDictionary]()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        print("you are at select room page")
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        showAllRooms()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return filteredRooms.count
        }
        return rooms.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RoomSearchCell", forIndexPath: indexPath)
        let room: NSMutableDictionary
        if searchController.active && searchController.searchBar.text != "" {
            room = filteredRooms[indexPath.row]
        } else {
            room = rooms[indexPath.row]
        }
        cell.textLabel?.text = "\(room["name"]!) at \(room["category"]!)"
        cell.detailTextLabel?.text = room["category"] as! String
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let room: NSMutableDictionary
        if searchController.active && searchController.searchBar.text != "" {
            room = filteredRooms[indexPath.row]
        } else {
            room = rooms[indexPath.row]
        }
        prefs.setValue(room["_id"], forKey: "currentRoom")
        let roomId = prefs.valueForKey("currentRoom")! as! String
        let user = prefs.valueForKey("currentUser")! as! String
        let roomData = NSMutableDictionary()
        roomData["_id"] = roomId
        roomData["user"] = user
        addToRoom(roomData)
    }
    
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredRooms = rooms.filter { room in
            return room["name"]!.lowercaseString.containsString(searchText.lowercaseString)
        }
        tableView.reloadData()
    }
    
    func showAllRooms(){
        RoomModel.getRooms(){
            data, response, error in
            do{
                if(data != nil){
                    if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSMutableArray {
                        for i in jsonResult {
                            let newRoom = i as! NSMutableDictionary
                            self.rooms.append(newRoom)
                        }
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
    
    func addToRoom(roomData: NSMutableDictionary){
        RoomModel.selectRoom(roomData){
            data, response, error in
            do{
                if(data != nil){
                    if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSMutableArray {
                        print(jsonResult)
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


