//
//  SymptomeSet.swift
//  iPark
//
//  Created by Kevin Giordani on 03/04/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation

class SymptomeSet{
    fileprivate var symSet: [Symptome] = []
    let symptomeDAO: SymptomeDAO = CoreDataDAOFactory.getInstance().getSymptomeDAO()
    
    var count: Int {
        return self.symSet.count
    }
    
    init(from symptomes: [Symptome]?) {
        if let symps = symptomes {
            for s in symps {
                self.symSet.append(s)
            }
        }
    }
    
    @discardableResult
    func add(_ symptome: Symptome) -> SymptomeSet {
        if !self.contains(symptome) {
            self.symSet.append(symptome)
            self.symptomeDAO.add(symptome)
        }
        return self
    }
    
    @discardableResult
    func remove(_ sym: Symptome) -> SymptomeSet {
        if self.contains(sym) {
            self.symSet.remove(at: self.symSet.index(of: sym)!)
            self.symptomeDAO.delete(for: sym)
        }
        return self
    }
    
    func get(_ i: Int) -> Symptome? {
        if(i < 0 || i >= symSet.count){
            return nil
        }
        return self.symSet[i]
    }
    
    func contains(_ symptome: Symptome) -> Bool {
        return self.symSet.contains(where: {$0==symptome})
    }
    
    func getLastSymptome() -> Symptome? {
        var lastSymptome: Symptome? = nil
        if self.count > 0 {
            let dateSet = self.filterByDate(for: Date(), before: true)
            if dateSet.count > 0 {
                dateSet.sortByDate()
                lastSymptome = dateSet.get(dateSet.count - 1)
            }
        }
        return lastSymptome
    }
    
    func filterByDate(for date: Date, before: Bool) -> SymptomeSet {
        if before {
            return SymptomeSet(from: self.symSet.filter { ($0.date! as Date) <= date })
        }
        else {
            return SymptomeSet(from: self.symSet.filter { ($0.date! as Date) > date })
        }
    }
    
    func sortByDate() {
        return self.symSet.sort(by: { (sym1, sym2) -> Bool in
            (sym1.date! as Date) < (sym2.date! as Date)
        })
    }
    

}
