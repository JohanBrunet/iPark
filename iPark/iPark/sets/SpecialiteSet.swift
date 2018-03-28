//
//  SpecialiteSet.swift
//  iPark
//
//  Created by Johan BRUNET on 27/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation

class SpecialiteSet {
    
    fileprivate var specSet: [Specialite] = []
    let specialiteDAO: SpecialiteDAO = CoreDataDAOFactory.getInstance().getSpecialiteDAO()
    
    var count: Int {
        return self.specSet.count
    }
    
    init(from specialites: [Specialite]?) {
        if let specs = specialites {
            for s in specs {
                self.specSet.append(s)
            }
        }
    }
    
    @discardableResult
    func add(_ specialite: Specialite) -> SpecialiteSet {
        if !self.contains(specialite) {
            self.specSet.append(specialite)
            self.specialiteDAO.add(specialite)
        }
        return self
    }
    
    @discardableResult
    func remove(_ specialite: Specialite) -> SpecialiteSet {
        if self.contains(specialite) {
            self.specSet.remove(at: self.specSet.index(of: specialite)!)
            self.specialiteDAO.delete(for: specialite)
        }
        return self
    }
    
    func get(_ i: Int) -> Specialite? {
        if(i < 0 || i >= specSet.count){
            return nil
        }
        return self.specSet[i]
    }
    
    func contains(_ specialite: Specialite) -> Bool {
        return self.specSet.contains(where: {$0==specialite})
    }
    
}
