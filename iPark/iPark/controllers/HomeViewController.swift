//
//  HomeViewController.swift
//  iPark
//
//  Created by Johan BRUNET on 10/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import UIKit

class HomeViewController:UIViewController {
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func viewDidLoad() {
        usernameLabel.text = "Bonjour " + UserDefaults.standard.string(forKey: "prenom")!
    }

}
