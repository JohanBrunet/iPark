//
//  DoctorViewController.swift
//  iPark
//
//  Created by Jade Hennebert on 21/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation
import UIKit

class DoctorViewController: UIViewController {

    
    
    @IBOutlet weak var titledName: UILabel!
    @IBOutlet weak var adress: UILabel!
    @IBOutlet weak var lastAppointment: UILabel!
    @IBOutlet weak var specialty: UILabel!
    var medecin: Medecin? = nil
    var posMedecin: Int? = nil
    
    override func viewDidLoad() {
        self.titledName.text = medecin?.titledName
        self.adress.text = medecin?.adr
        if (medecin?.spe) != nil {
            self.specialty.text = medecin?.spe?.libelle
        }
        else {
            self.specialty.text = "Non renseigné"
        }
        self.lastAppointment.text = "Pas de rendez-vous précédent"
    }
    
    @IBAction func deleteMedecin(_ sender: Any) {
        self.performSegue(withIdentifier: "showPatientInfos", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! PersonalInfoViewController
        destinationVC.medecinSet?.remove(medecin!)
    }
}
