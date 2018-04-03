//
//  Medicament.swift
//  iPark
//
//  Created by Johan BRUNET on 31/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation
import CoreData

extension Medicament {
    
    var nom: String {
        get {
            return self.nom_medicament!
        }
        set {
            self.nom_medicament = newValue
        }
    }
    
    var doses: [String] {
        return self.doses_medicament as! [String]
    }
    
    convenience init(nom: String, doses: [String]) {
        self.init(context: CoreDataManager.context)
        self.nom_medicament = nom
        self.doses_medicament = doses as NSObject
    }
    
}
