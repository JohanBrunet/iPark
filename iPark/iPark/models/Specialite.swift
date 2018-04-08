//
//  Specialite.swift
//  iPark
//
//  Created by Johan BRUNET on 27/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation

extension Specialite {
    
    var label: String {
        get {
            return self.libelle!
        }
    }
    
    convenience init(withLabel lb: String) {
        self.init(context: CoreDataManager.context)
        self.libelle = lb
    }
}
