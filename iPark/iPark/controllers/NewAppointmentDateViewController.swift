//
//  NewAppointmentDateviewController.swift
//  iPark
//
//  Created by Johan BRUNET on 27/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import UIKit

class NewAppointmentDateViewController: UIViewController {
    
    @IBOutlet weak var rappel: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    var medecin: Medecin? = nil
    var newRDV: RendezVous? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func submitForm(_ sender: Any) {
        let date = (self.datePicker?.date != nil) ? self.datePicker.date : Date()
        self.newRDV = RendezVous(for: date, with: self.medecin!)
        self.performSegue(withIdentifier: "showRDVList", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! CalendarViewController
        destinationVC.rdvs?.add(newRDV!)
    }
}
