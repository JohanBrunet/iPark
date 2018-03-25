//
//  NewDoctorViewController.swift
//  iPark
//
//  Created by Jade Hennebert on 21/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class NewDoctorViewController:UIViewController{
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var specialty: UIPickerView!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var phone: UITextField!
    
    var newMed: Medecin? = nil
    
    @IBAction func submitForm(_ sender: Any) {
        let tab: [UITextField] = [name, address, phone]
        if FormValidator.formIsValid(tab) {
            newMed = Medecin(ln: name.text!, addr: address.text!, ph: phone.text!)
            self.performSegue(withIdentifier: "showPersonalInfos", sender: self)
        }
        else {
            let alert = UIAlertController(title: "Formulaire invalide", message: "Veuillez remplir tous les champs", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! PersonalInfoViewController
        destinationVC.medecinSet?.add(newMed!)
    }
}
