//
//  ViewController.swift
//  safeApp
//
//  Created by HGPMAC82 on 6/25/19.
//  Copyright © 2019 HGPMAC82. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var myImageView: UIImageView!
    
    
    @IBOutlet weak var importimage: UIButton!
    
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    
    @IBAction func action(_ sender: UIButton)
    {
        print("Entered user auth action")
        
        
         if emailText.text != "" && passwordText.text != ""
         {
            if segmentControl.selectedSegmentIndex == 0 //Login User
            {
                Auth.auth().signIn(withEmail: emailText.text!, password:  passwordText.text!, completion: { (user, error) in
                    if user != nil
                    {
                    // Sign in successful
                        self.performSegue(withIdentifier: "LoginToHomePage", sender: self)
                    }
                    else
                    {
                        if let myError = error?.localizedDescription
                        {
                            print(myError)
                        }
                        else
                        {
                           print("ERROR")
                        }
                    }
                })
            }
            else //Sign up user 
             {
                
                print("entered create user")
                Auth.auth().createUser(withEmail: emailText.text!, password:  passwordText.text!, completion: { (user, error) in
                    if user != nil
                    {
                       self.performSegue(withIdentifier: "LoginToHomePage", sender: self)
                    }
                    else
                    {
                        if let myError = error?.localizedDescription
                        {
                            print(myError)
                        }
                        else
                        {
                            print("ERROR")
                        }
                    }
                })
            }
                
        }
        
       
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func didRecieveMemoryWarning() {
        didRecieveMemoryWarning()
    //dispose of any reasources that can be recreated
    }
}







