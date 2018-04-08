//
//  Symptome.swift
//  iPark
//
//  Created by Kevin Giordani on 03/04/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation

extension Symptome{
    
    var etatPatient: String {
        get {
            return self.etat!
        }
        set {
            self.etat = newValue
        }
    }
    
    var dateSymptome : NSDate {
        get {
            return self.date!
        }
        set {
            self.date = newValue
        }
    }
    
    var evenementsSignal : [String]?{
        get {
            return self.evenements as? [String]
        }
        set {
            self.evenements = newValue as NSObject?
        }
    
        }
    
    convenience init(etat: String, date : NSDate, ev : [String]?) {
        self.init(context: CoreDataManager.context)
        self.etatPatient = etat
        self.dateSymptome = date
        self.evenementsSignal = ev
    }
    
    
    
    
    
}
