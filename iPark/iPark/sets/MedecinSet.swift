//
//  MedecinSet.swift
//  iPark
//
//  Created by Johan BRUNET on 23/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation
import CoreData

class MedecinSet {
    
    fileprivate var medSet: [Medecin] = []
    let medecinDAO: MedecinDAO = CoreDataDAOFactory.getInstance().getMedecinDAO()
    
    init(from medecins: [Medecin]) {
        for m in medecins {
            self.medSet.append(m)
        }
    }
    
    @discardableResult
    func add(medecin: Medecin) -> MedecinSet {
        if !self.medSet.contains(medecin) {
            self.medSet.append(medecin)
            if let spe = medecin.spe {
                
            }
        }
        return self
    }
    
    @discardableResult
    func remove(medecin: Medecin) -> MedecinSet {
        while let p = self.medecinDAO.search(forMedecin: medecin){
            self.medecinDAO.delete(for: p)
        }
        self.medecinDAO.save()
        return self
    }
    
    func contains(medecin: Medecin) -> Bool{
        return self.medSet.contains(where: {$0==medecin})
    }
    
}
