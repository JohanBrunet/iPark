//
//  MedicamentSet.swift
//  iPark
//
//  Created by Johan BRUNET on 02/04/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation

class MedicamentSet {
    
    fileprivate var medSet: [Medicament] = []
    let medicamentDAO: MedicamentDAO = CoreDataDAOFactory.getInstance().getMedicamentDAO()
    
    var count: Int {
        return self.medSet.count
    }
    
    init(from medicaments: [Medicament]?) {
        if let meds = medicaments {
            for m in meds {
                self.medSet.append(m)
            }
        }
    }
    
    @discardableResult
    func add(_ medicament: Medicament) -> MedicamentSet {
        if !self.contains(medicament) {
            self.medSet.append(medicament)
            self.medicamentDAO.add(medicament)
        }
        return self
    }
    
    @discardableResult
    func remove(_ medicament: Medicament) -> MedicamentSet {
        if self.contains(medicament) {
            self.medSet.remove(at: self.medSet.index(of: medicament)!)
            self.medicamentDAO.delete(for: medicament)
        }
        return self
    }
    
    func get(_ i: Int) -> Medicament? {
        if(i < 0 || i >= medSet.count){
            return nil
        }
        return self.medSet[i]
    }
    
    func contains(_ medicament: Medicament) -> Bool {
        return self.medSet.contains(where: {$0==medicament})
    }
    
    func sortByName() {
        return self.medSet.sort(by: { (med1, med2) -> Bool in
            med1.nom <= med2.nom
        })
    }
    
}
