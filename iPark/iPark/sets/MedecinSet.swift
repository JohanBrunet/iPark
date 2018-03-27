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
    
    var count: Int {
        return self.medSet.count
    }
    
    init(from medecins: [Medecin]?) {
        if let meds = medecins {
            for m in meds {
                self.medSet.append(m)
            }
        }
    }
    
    @discardableResult
    func add(_ medecin: Medecin) -> MedecinSet {
        if !self.contains(medecin) {
            self.medSet.append(medecin)
            self.medecinDAO.add(medecin)
        }
        return self
    }
    
    @discardableResult
    func remove(_ medecin: Medecin) -> MedecinSet {
        if self.contains(medecin) {
            self.medSet.remove(at: self.medSet.index(of: medecin)!)
            self.medecinDAO.delete(for: medecin)
        }
        return self
    }
    
    func get(_ i: Int) -> Medecin? {
        if(i < 0 || i >= medSet.count){
            return nil
        }
        return self.medSet[i]
    }
    
    func contains(_ medecin: Medecin) -> Bool {
        return self.medSet.contains(where: {$0==medecin})
    }
    
}
