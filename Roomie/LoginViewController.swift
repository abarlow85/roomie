//
//  LoginViewController.swift
//  Roomie
//
//  Created by Gabe Ratcliff on 5/17/16.
//  Copyright © 2016 Alec Barlow. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    let prefs = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.passwordTextField.delegate = self
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
                if segue.identifier == "LoginSegue"{
                    let navigationController = segue.destinationViewController as! UINavigationController
                    let controller = navigationController.topViewController as! TaskViewController
                }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        var userData = NSMutableDictionary()
        
        if emailTextField.text!.isEmpty {
            errorLabel.text = "All fields are required"
            return false
        }
        if passwordTextField.text!.isEmpty {
            errorLabel.text = "All fields are required"
            return false
        }
        self.view.endEditing(true)
        
        //        userData.setValue(nameTextField.text!, forKey: "name")
        //        userData.setValue(emailTextField.text!, forKey: "email")
        //        userData.setValue(passwordTextField.text!, forKey: "password")
        //        userData.setValue(roomTextField.text!, forKey: "room")
        userData["email"] = emailTextField.text!
        userData["password"] = passwordTextField.text!
        
        
        UserModel.loginUser(userData, completionHandler: { data, response, error in
            
            do {
                //                print(response)
                if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
                    print(jsonResult)
                    if let checkForFail = jsonResult["error"] {
                        print(checkForFail)
                        let fail = checkForFail as! String
                        dispatch_async(dispatch_get_main_queue(), {
                            self.errorLabel.text = fail
                        })
                    } else {
                        let user = jsonResult["user"] as! String
                        self.prefs.setValue(user, forKey: "currentUser")
                        
                        dispatch_async(dispatch_get_main_queue(), {
                            self.performSegueWithIdentifier("LoginSegue", sender: jsonResult)
                        })
                    }
                    
                    
                }
                
            }catch {
                print(data)
                print(response)
                print(error)
            }
        })
        return true
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
