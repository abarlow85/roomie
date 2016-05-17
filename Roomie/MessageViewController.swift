//
//  MessageViewController.swift
//  Roomie
//
//  Created by Gabe Ratcliff on 5/17/16.
//  Copyright © 2016 Alec Barlow. All rights reserved.
//


import UIKit

class MessageViewController: UITableViewController {
    weak var backButtonDelegate: BackButtonDelegate?
    @IBAction func backButtonPressed(sender: UIBarButtonItem) {
        backButtonDelegate?.backButtonPressedFrom(self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //        if segue.identifier == "LogoutSegue"{
        //            let navigationConroller = segue.destinationViewController as! UINavigationController
        //            let controller = navigationConroller.topViewController as! LoginViewController
        //        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

