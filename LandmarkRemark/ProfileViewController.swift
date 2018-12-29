//
//  ProfileViewController.swift
//  LandmarkRemark
//
//  Created by Shanya Vairawanathan on 27/12/18.
//  Copyright © 2018 Shanya Vairawanathan. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth


class ProfileViewController: UIViewController {
    
    
    @IBAction func logout(_ sender: UIButton)
    {
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "logout", sender: self)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Auth.auth().currentUser?.email as Any)
    }
    
    override func didReceiveMemoryWarning() {
        
    }
}
