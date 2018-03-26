//
//  MedecinModel.swift
//  iPark
//
//  Created by Johan BRUNET on 23/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation

extension Medecin {
    
    var nom: String {
        get {
            return self.nom_medecin!
        }
        set {
            self.nom_medecin = newValue
        }
    }
    
    var adr: String {
        get {
            return self.adresse!
        }
        set {
            self.adresse = newValue
        }
    }
    
    var tel: String {
        get {
            return self.telephone!
        }
        set {
            self.telephone = newValue
        }
    }
    
    var spe: Specialite? {
        return self.specialite
    }
    
    var titledName: String {
        return "Dr. " + self.nom
    }
    
    convenience init(ln: String, addr: String, ph: String) {
        self.init(context: CoreDataManager.context)
        self.nom_medecin = ln
        self.adresse = addr
        self.telephone = ph
    }
    
    convenience init(ln: String, addr: String, ph: String, sp: Specialite) {
        self.init(context: CoreDataManager.context)
        self.nom_medecin = ln
        self.adresse = addr
        self.telephone = ph
        self.specialite = sp
    }
}
