//
//  FirstLaunchViewController.swift
//  iPark
//
//  Created by Johan BRUNET on 10/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import UIKit
import CoreData

class FirstLaunchViewController:UIViewController {
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var adress: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var birthdate: UIDatePicker!
    @IBOutlet weak var register: UIButton!
    
    func formIsValid(_ tab:[UITextField]!) -> Bool {
        var flag: Bool = false
        if let t = tab {
            flag = (t.count == filterValues(tab).count)
        }
        return flag
    }
    
    func filterValues(_ inputs:[UITextField]) -> [UITextField]! {
        return inputs.filter{(item) in !(item.text?.isEmpty ?? true)}
    }
    
    func createPatient() throws -> Patient {
        let tab: [UITextField] = [lastName, firstName, adress, phoneNumber]
        if formIsValid(tab) {
            let patient: Patient = Patient(context : CoreDataManager.context)
            patient.nom_patient = lastName.text
            patient.prenom_patient = firstName.text
            //patient.date_naissance = birthdate.date
            patient.adresse = Adresse(context: CoreDataManager.context)
            patient.telephone = phoneNumber.text
            do {
                try CoreDataManager.save()
                return patient
            }
            catch let error as NSError {
                throw error
            }
        }
        else {
            let nilValues = filterValues(tab)
            throw Error(nilValues)
        }
    }

}
