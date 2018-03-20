//
//  PatientModel.swift
//  iPark
//
//  Created by Johan BRUNET on 12/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation

class PatientModel {

    var nom: String
    
    var prenom: String
    
    var adresse: String
    
    var date_naissance: NSDate?
    
    init(nom: String, prenom: String, adresse: String, date_naissance: NSDate?) {
        self.nom = nom
        self.prenom = prenom
        self.adresse = adresse
        self.date_naissance = date_naissance
    }
    
    init(_ patient: Patient) throws {
        self.nom = patient.nom_patient!
        self.prenom = patient.prenom_patient!
        self.adresse = patient.adresse!
        self.date_naissance = patient.date_naissance!
    }
}
