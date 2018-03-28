//
//  RendezVous.swift
//  iPark
//
//  Created by Johan BRUNET on 27/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation


extension RendezVous {
    
    var dateRDV: Date {
        return self.date! as Date
    }
    
    var rappelRDV: Date? {
        return self.rappel! as Date
    }
    
    var med: Medecin? {
        return self.medecin
    }
    
    convenience init(for date: Date, with medecin: Medecin) {
        self.init(context: CoreDataManager.context)
        self.date = date as NSDate
        self.medecin = medecin
    }
    
    convenience init(for date: Date, rappel: Date, with medecin: Medecin) {
        self.init(context: CoreDataManager.context)
        self.date = date as NSDate
        self.rappel = rappel as NSDate
        self.medecin = medecin
    }
    
}
