//
//  Prise.swift
//  iPark
//
//  Created by Johan BRUNET on 31/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation
import CoreData

extension Prise {
    
    var rappelPrise: Date {
        return self.rappel! as Date
    }
    
    var doseMed: String {
        get {
            return self.dose!
        }
        set {
            self.dose = newValue
        }
    }
    
    var quantiteMed: Int {
        get {
            return Int(self.quantite)
        }
        set {
            self.quantite = Int16(newValue)
        }
    }
    
    var med: Medicament {
        return self.medicament!
    }
    
    convenience init(forMed med: Medicament, withDose dose: String, withQuant quant: Int, at rappel: Date) {
        self.init(context: CoreDataManager.context)
        self.medicament = med
        self.dose = dose
        self.quantite = Int16(quant)
        self.rappel = rappel as NSDate
    }
    
}
