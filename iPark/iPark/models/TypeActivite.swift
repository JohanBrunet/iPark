//
//  TypeActivite.swift
//  iPark
//
//  Created by Kevin Giordani on 01/04/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation

extension TypeActivite{
    
    var nomType: String {
        get {
            return self.libelle!
        }
        set {
            self.libelle = newValue
        }
    }
    
    convenience init(nom: String) {
        self.init(context: CoreDataManager.context)
        self.nomType = nom
    }
}
