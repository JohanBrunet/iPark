//
//  MyAppointmentViewController.swift
//  iPark
//
//  Created by Jade Hennebert on 21/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation
import UIKit

class MyAppointmentViewController:UIViewController{
    
    @IBOutlet weak var toggleRappel: UISwitch!
    @IBOutlet weak var specialiteMedecinLabel: UILabel!
    @IBOutlet weak var medecinLabel: UILabel!
    @IBOutlet weak var adresseLabel: UILabel!
    @IBOutlet weak var dateRDVLabel: UILabel!
    @IBOutlet weak var rappelLabel: UILabel!
    var rdv: RendezVous? = nil
    
    override func viewDidLoad() {
        let med: Medecin = (self.rdv?.med)!
        self.specialiteMedecinLabel.text = med.spe?.label
        self.medecinLabel.text = med.titledName
        self.adresseLabel.text = med.adr
        
        let dateRDVFormatted = DateHelper.formatDate(date: (self.rdv?.dateRDV)!, pattern: "EEEE dd MMMM yyyy à HH:mm")
        self.dateRDVLabel.text = dateRDVFormatted
        
        if let rappel = self.rdv?.rappelRDV {
            if rappel < Date() {
                self.toggleRappel.setOn(false, animated: false)
            }
            let rappelString = DateHelper.getRappelString(rdv: (self.rdv?.dateRDV)!, rappel: rappel)
            self.rappelLabel.text = rappelString + " avant"
        }
        else {
            self.toggleRappel.setOn(false, animated: false)
            self.rappelLabel.text = "Pas de rappel pour ce rendez-vous"
        }
    }
    
    @IBAction func manageNotification(_ sender: Any) {
        if let rappel = self.rdv?.rappelRDV {
            if rappel < Date() {
                self.toggleRappel.setOn(false, animated: false)
            }
            else {
                let dateFormatted = DateHelper.formatDate(date: (self.rdv?.dateRDV)!, pattern: "EEEEddMMMMyyyyHH:mm")
                print("date rdv : " + dateFormatted)
                if toggleRappel.isOn {
                    let notifID: String = (self.rdv?.med?.nom)! + dateFormatted
                    let notifTitle: String = "Rendez-vous"
                    let rappelString = DateHelper.getRappelString(rdv: (self.rdv?.dateRDV)!, rappel: rappel)
                    let notifBody: String =  "Vous avez rendez-vous avec " + (self.rdv?.med?.titledName)! + "dans " + rappelString
                    print("ID : " + notifID)
                    print("Body : " + notifBody)
                    AppDelegate.notification.addNotification(identifier: notifID, title: notifTitle, body: notifBody, date: DateHelper.removeSeconds(from: rappel), repeatable: false)
                }
                else {
                    let notifID: String = (self.rdv?.med?.nom)! + dateFormatted
                    AppDelegate.notification.removeNotification(identifier: [notifID])
                }
            }
        }
    }
    
}
