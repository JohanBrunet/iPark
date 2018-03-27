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
        var title: String = ""
        let doctors: [String] = [
            "neuropsychologue","neurologue", "médecin généraliste", "psychiatre", "neurochirurgien", "médecin de structure antidouleur", "gériatre", "médecin spécialiste en médecine physique", "gastro-entérologue", "urologue", "gynécologue", "sexologue", "ORL-phoniatre", "rhumatologue", "chirurgien orthopédique", "pneumologue",
             "cardiologue", "médecin du travail", "chirurgien-dentiste", "ergothérapeute", "psychomotricien", "orthoptiste"
            
        ]
        if let spec = self.specialite?.label {
            if doctors.contains(spec) {
                title = "Dr. "
            }
            else {
                title = "M./Mme. "
            }
        }
        else {
            title = "M./Mme. "
        }
        return title + self.nom
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
