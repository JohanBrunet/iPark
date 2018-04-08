//
//  Activity.swift
//  iPark
//
//  Created by Jade Hennebert on 24/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation
extension Activite {
    
    var nomActivite: String? {
        get {
            return self.libelle
        }
        set {
            self.libelle = newValue
        }
    }
    
    var typeActivite: TypeActivite?{
        get{
            return self.type
        }
        set{
            self.type = newValue
        }
    }
    
    
    var dureeActivite: Int32 {
        get {
            return self.duree
        }
        set {
            self.duree = newValue
        }
    }
    
    var dateActivite: NSDate! {
        get {
            return self.date
        }
        set {
            self.date = newValue
        }
    }
    
    var remarqueActivite: String? {
        get{
            return self.remarque
        }
        
        set{
            self.remarque = newValue
        }
    }
    
    convenience init(ta: TypeActivite, dur: Int32, date:NSDate!, rem: String?) {
        self.init(context: CoreDataManager.context)
        self.typeActivite = ta
        self.dureeActivite = dur
        self.dateActivite = date
        self.remarqueActivite = rem
    }
    
    convenience init(la: String, dur: Int32, date:NSDate!, rem: String?) {
        self.init(context: CoreDataManager.context)
        self.nomActivite = la
        self.dureeActivite = dur
        self.dateActivite = date
        self.remarqueActivite = rem
    }
}
