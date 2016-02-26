//
//  LoginViewController.swift
//  PhotoPost
//
//  Created by Nishant Raman on 2/26/16.
//  Copyright © 2016 Nishant Raman. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    @IBAction func signIn(sender: AnyObject) {
        
        PFUser.logInWithUsernameInBackground(usernameField.text!, password: passwordField.text!) { (user: PFUser?, error: NSError?) -> Void in
            
            if let u = user {
                print("You are logged in")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
                
            }
            
        }
    }
    
    @IBAction func signUp(sender: AnyObject) {
        
        let newUser = PFUser()
        
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        newUser.signUpInBackgroundWithBlock { (success : Bool, error: NSError?) -> Void in
            if success {
                print("Yay, created a user")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
                
            } else {
                print(error?.localizedDescription)
                if error!.code == 202 {
                    print("Username is taken")
                }
            }
        }
    }
   

}
