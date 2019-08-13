//
//  ViewController2.swift
//  safeApp
//
//  Created by HGPMAC82 on 7/9/19.
//  Copyright © 2019 HGPMAC82. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController2: UIViewController {
    
    
    
    @IBOutlet weak var mainBannerImage: UIImageView!
    @IBAction func action(_ sender: UIButton)
    {
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "segue2", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleFunction()
        
    }
    
    func styleFunction(){
        mainBannerImage.layer.shadowOpacity = 0.7
        mainBannerImage.layer.shadowOffset = CGSize(width: 3, height: 3)
        mainBannerImage.layer.shadowRadius = 15.0
        mainBannerImage.layer.shadowColor = UIColor.darkGray.cgColor
    }
    

   

}
