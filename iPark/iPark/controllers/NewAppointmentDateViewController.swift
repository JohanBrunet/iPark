//
//  NewAppointmentDateviewController.swift
//  iPark
//
//  Created by Johan BRUNET on 27/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import UIKit

class NewAppointmentDateViewController: UIViewController {
    
    @IBOutlet weak var rappel: UIDatePicker!
    @IBOutlet weak var datePicker: UIDatePicker!
    var medecin: Medecin? = nil
    var newRDV: RendezVous? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.rappel.countDownDuration = 0
        self.rappel.locale = Locale(identifier: "fr_FR")
    }
    
    @IBAction func submitForm(_ sender: Any) {
        let date = (self.datePicker?.date != nil) ? self.datePicker.date : Date()
        let tempsPrep = -self.rappel.countDownDuration
        let dateRappel = date.addingTimeInterval(tempsPrep)
        self.newRDV = RendezVous(for: date, rappel: dateRappel, with: self.medecin!)
        
        let notifID: String = (self.newRDV?.med?.nom)! + DateHelper.formatDate(date: (self.newRDV?.dateRDV)!, pattern: "ddMMyyyyHHmm")
        let notifTitle: String = "Rendez-vous"
        let notifBody: String =  "Vous avez rendez-vous avec " + (self.newRDV?.med?.titledName)! + " dans " + DateHelper.getRappelString(rdv: date, rappel: dateRappel)
        AppDelegate.notification.addNotification(identifier: notifID, title: notifTitle, body: notifBody, date: DateHelper.removeSeconds(from: dateRappel), repeatable: false)
        self.performSegue(withIdentifier: "showRDVList", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! CalendarViewController
        destinationVC.rdvs?.add(newRDV!)
        var filter: Int = 0
        if (DateHelper.truncateToDay(from: (newRDV?.dateRDV)!)) == DateHelper.truncateToDay(from: Date()) {
            filter = 1
        }
        if (DateHelper.truncateToDay(from: (newRDV?.dateRDV)!)) > DateHelper.truncateToDay(from: Date()) {
            filter = 2
        }
        destinationVC.filterButton.selectedSegmentIndex = filter
    }
}
