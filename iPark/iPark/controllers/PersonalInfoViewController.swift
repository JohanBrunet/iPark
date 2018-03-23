//
//  PersonalInfoViewController.swift
//  iPark
//
//  Created by Jade Hennebert on 20/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation
import UIKit

class PersonalInfoViewController:UIViewController {
   
    
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var adress: UILabel!
    
    override func viewDidLoad() {
        self.fullName.text = UserDefaults.standard.string(forKey: "prenom")! + " " + UserDefaults.standard.string(forKey: "nom")!
        self.adress.text = UserDefaults.standard.string(forKey: "adresse")!
        let birthdate: Date = UserDefaults.standard.object(forKey: "date_naissance") as! Date
        let today: Date = Date()
        let age: Int = Calendar.current.dateComponents([.year], from: birthdate, to: today).year!
        self.age.text = age.description + " ans"
    }
    
}
