//
//  MedecinSet.swift
//  iPark
//
//  Created by Johan BRUNET on 23/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation

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
            let rdvsMed = RendezVousSet(from: CoreDataDAOFactory.getInstance().getRendezVousDAO().getAll()).filterByMedecin(for: medecin)
            while rdvsMed.count > 0 {
                let rdv = rdvsMed.get(rdvsMed.count - 1)!
                rdvsMed.remove(rdv)
            }
            
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
    
    func sortByName() {
        return self.medSet.sort(by: { (med1, med2) -> Bool in
            med1.nom <= med2.nom
        })
    }
    
    func sortBySpecialite() {
        return self.medSet.sort(by: { (med1, med2) -> Bool in
            (med1.spe?.label)! <= (med2.spe?.label)!
        })
    }
    
}
