//
//  FirstLaunchViewController.swift
//  iPark
//
//  Created by Johan BRUNET on 10/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import UIKit

class FirstLaunchViewController: UIViewController {
    
    
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var adress: UITextField!
    @IBOutlet weak var birthdate: UIDatePicker!
    
    func formIsValid(_ tab:[UITextField]!) -> Bool {
        return (tab.count == filterValues(tab).count)
    }
    
    func filterValues(_ inputs:[UITextField]) -> [UITextField]! {
        return inputs.filter{(item) in !(item.text?.isEmpty ?? true)}
    }
    
    
    @IBAction func submitForm(_ sender: Any) {
        let tab: [UITextField] = [lastName, firstName, adress]
        if formIsValid(tab) {
            let date:NSDate? = birthdate.date as NSDate?
            do {
                let patient: PatientModel = try PatientModel(nom: lastName.text!, prenom: firstName.text!, adresse: adress.text!, date_naissance: date)
                UserDefaults.standard.set(true, forKey: "launchedBefore")
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                let view = storyboard.instantiateViewController(withIdentifier: "homeView") as! HomeViewController
                self.present(view, animated: true, completion: nil)
            }
            catch {
                let alert = UIAlertController(title: "Erreur insertion", message: "Erreur lors de l'insertion des données", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        else {
            let alert = UIAlertController(title: "Formulaire invalide", message: "Veuillez remplir tous les champs", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
