//
//  RegisterViewController.swift
//  Roomie
//
//  Created by Alec Barlow on 5/17/16.
//  Copyright © 2016 Alec Barlow. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    let prefs = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.passwordTextField.delegate = self
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        var userData = NSMutableDictionary()
        
        if nameTextField.text!.isEmpty {
            errorLabel.text = "All fields are required"
            return false
        }
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
        userData["name"] = nameTextField.text!
        userData["email"] = emailTextField.text!
        userData["password"] = passwordTextField.text!
        
        
        UserModel.registerUser(userData, completionHandler: { data, response, error in
         
            do {
                print(response)
                if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
                    
                    let user = jsonResult["user"] as! String
                    self.prefs.setValue(user, forKey: "currentUser")
                    dispatch_async(dispatch_get_main_queue(), {
                        self.performSegueWithIdentifier("RoomSelection", sender: jsonResult)
                    })
                    
                }
                
            }catch {
                print("something is wrong")
            }
        })
        return true
    }
    
    
}

