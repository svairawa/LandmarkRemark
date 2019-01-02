//
//  LoginViewController.swift
//  LandmarkRemark
//
//  Created by Shanya Vairawanathan on 27/12/18.
//  Copyright © 2018 Shanya Vairawanathan. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth


class LoginViewController: UIViewController {
    
    //Creating outlets for the components on the UI
    @IBOutlet weak var segmentControl: UISegmentedControl!

    @IBOutlet weak var emailtxt: UITextField!
    
    @IBOutlet weak var passwordtxt: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    //Login authentication action function
    @IBAction func loginBtnAction(_ sender: Any) {
        
        if emailtxt.text != "" && passwordtxt.text != ""
        {
            //If the segment is login, then authenticate
            if segmentControl.selectedSegmentIndex == 0 //Login User
            {
                Auth.auth().signIn(withEmail: emailtxt.text!, password: passwordtxt.text!, completion: { (user, error) in
                    
                    if user != nil
                    {
                        //Sign in successful
                        self.performSegue(withIdentifier: "login", sender: self)
                    }
                    else
                    {
                        if let myError = error?.localizedDescription
                        {
                            print(myError)
                        }
                        else
                        {
                            print("error")
                        }
                    }
                    
                    
                })
                
            }
            else //Register the user
            {
            
                Auth.auth().createUser(withEmail: emailtxt.text!, password: passwordtxt.text!, completion: {(user, error) in
                    if user != nil
                    {
                        print("success")
                    }
                    else
                    {
                        if let myError = error?.localizedDescription
                        {
                            print(myError)
                        }
                        else
                        {
                            print("Error")
                        }
                    }
                })
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        
    }
}
