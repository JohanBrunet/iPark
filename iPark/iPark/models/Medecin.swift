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
    
    var prenom: String {
        get {
            return self.prenom_medecin!
        }
        set {
            self.prenom_medecin = newValue
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
    
    var fullName: String {
        let fn = self.prenom + " " + self.nom
        return fn
    }
    
    convenience init(fn: String, ln: String, addr: String, ph: String) {
        self.init(context: CoreDataManager.context)
        self.prenom_medecin = fn
        self.nom_medecin = ln
        self.adresse = addr
        self.telephone = ph
    }
    
    convenience init(fn: String, ln: String, addr: String, ph: String, sp: Specialite) {
        self.init(context: CoreDataManager.context)
        self.prenom_medecin = fn
        self.nom_medecin = ln
        self.adresse = addr
        self.telephone = ph
        self.specialite = sp
    }
}
